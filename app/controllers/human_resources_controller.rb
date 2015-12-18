class HumanResourcesController < ApplicationController
  include ApplicationHelper

  layout "application_loggedin"

  def index
    render 'human_resources/index'
  end

  # ================== Employee Accounts Management ================== #

  def employee_accounts_management
    order_parameter = ActiveRecord::Base.sanitize(aggregated_search_queries(params[:order_parameter], 'employee_accounts_management', "order_parameter" ,"created_at")).gsub("'", '')
    order_orientation = ActiveRecord::Base.sanitize(aggregated_search_queries(params[:order_orientation], 'employee_accounts_management',"order_orientation", "DESC")).gsub("'", '')
    current_limit = ActiveRecord::Base.sanitize(aggregated_search_queries(params[:current_limit], 'employee_accounts_management',"current_limit","10")).gsub("'", '')
    search_field = ActiveRecord::Base.sanitize(aggregated_search_queries(params[:search_field], 'employee_accounts_management',"search_field","")).gsub("'", '')

    begin
      sql = "SELECT employees.id as id, actors.name as name, dutystatus.active as active, branches.name as branch_name, employees.created_at as created_at, employees.updated_at as updated_at, actors.id  as actors_id
    FROM employees
    INNER JOIN actors ON employees.actor_id = actors.id
    INNER JOIN branches ON employees.branch_id = branches.id
    INNER JOIN ( SELECT employee_id, active, max(duty_statuses.created_at) FROM duty_statuses GROUP BY employee_id )
    AS dutystatus ON dutystatus.employee_id = employees.id WHERE" +
          "(employees.id LIKE '%" + search_field + "%' " + ")" + " OR " +
          "(actors.name LIKE '%" + search_field + "%' " + ")" + " OR " +
          "(dutystatus.active LIKE '%" + search_field + "%' " + ")" + " OR " +
          "(branches.name LIKE '%" + search_field + "%' " + ")" + " OR " +
          "(employees.created_at LIKE '%" + search_field + "%' " + ")" + " OR " +
          "(employees.updated_at LIKE '%" + search_field + "%' " + ")" + " " +
          "ORDER BY " + order_parameter + " " + order_orientation;
      @employee_accounts = ActiveRecord::Base.connection.execute(sql)
      @employee_accounts = Kaminari.paginate_array(@employee_accounts.each( :as => :array )).page(params[:page]).per(current_limit)
    rescue
      flash[:general_flash_notification] = "Error has Occured"
    end

    #Render
    render 'human_resources/employee_accounts_management/index'
  end

  def employee_registration
    @branches = Branch.all()
    render 'human_resources/employee_accounts_management/employee_registration'
  end

  def search_suggestions_employees
    employees = Employee.includes(:actor).where("actors.name LIKE (?)", "%#{ params[:query] }%").pluck("actors.name")
    direct = "{\"query\": \"Unit\",\"suggestions\":" + employees.to_s + "}"
    respond_to do |format|
      format.all { render :text => direct}
    end
  end

  def delete_employee
    @employees = Employee.all()
    employee = Employee.find(params[:employee_id])
    deleteEmployeeName = employee.actor.name
    flash[:general_flash_notification] = 'Employee ' + deleteEmployeeName + ' was successfully deleted.'
    flash[:general_flash_notification_type] = 'affirmative'
    employee.destroy
    redirect_to :action => "employee_accounts_management"
  end

  def employee_profile
    @selected_model = 'Employee'
    @actors = Actor.includes(:employee).joins(:employee)
    actor_profile
    @selected_employee = Employee.find_by_actor_id( params[:actor_id] )
    if @selected_employee.present?
      @selected_branch = Branch.find(@selected_employee.branch_id)
    end
    render 'shared/actor_profile'
  end

  # ================== Attendances ================== #

  def index
  end

  def attendances
    order_parameter = aggregated_search_queries(params[:order_parameter], 'attendances', "order_parameter" ,"attendances.created_at")
    order_orientation = aggregated_search_queries(params[:order_orientation], 'attendances', "order_orientation", "DESC")
    current_limit = aggregated_search_queries(params[:current_limit], 'attendances', "current_limit","10")
    search_field = aggregated_search_queries(params[:search_field], 'attendances', "search_field","")
    begin
      @attendances = Attendance
      .includes(employee: [:actor])
      .joins(employee: [:actor])
      .where("actors.name LIKE ? OR attendances.id LIKE ? OR attendances.timein LIKE ? OR attendances.timeout LIKE ? OR attendances.remark LIKE ? OR attendances.updated_at LIKE ? OR attendances.created_at LIKE ?", "%#{search_field}%","%#{search_field}%","%#{search_field}%","%#{search_field}%","%#{search_field}%","%#{search_field}%","%#{search_field}%" )
      .order(order_parameter + ' ' + order_orientation)
      @attendances = Kaminari.paginate_array(@attendances).page(params[:page]).per(current_limit)
    rescue => ex
      flash[:general_flash_notification] = "Error has Occured"
    end
    render 'human_resources/attendance/attendances'
  end

  def branch_attendance_sheet
    @branches = Branch.all
    @start_date = DateTime.strptime(params[:start_date],"%Y-%m-%d")
    @end_date = DateTime.strptime(params[:end_date],"%Y-%m-%d")
    @number_of_days = (@end_date - @start_date).to_i + 1
    if params[:branch][:id] && params[:start_date] && params[:end_date]
      @selected_branch = Branch.find(params[:branch][:id])
      @employees_by_branch = Employee.includes(:actor).joins(:actor).where("branch_id = ?", "#{@selected_branch.id}")
    end
    @selected_branch ||= Branch.new
    render 'human_resources/attendance/branch_attendance_sheet'
  end

  def process_branch_attendance_sheet
    @sample = params[:attendance]
    render 'test/index'
  end

  def employee_attendance_history
  end

  def new_attendance
    initialize_employee_selection
    @selected_attendance = Attendance.new
    render 'human_resources/attendance/attendance_form'
  end

  def edit_attendance
    initialize_employee_selection
    @selected_attendance = Attendance.find(params[:attendance_id])
    render 'human_resources/attendance/attendance_form'
  end

  def process_attendance_form
    begin
      if( params[:attendance][:id].present? )
        myAttendance = Attendance.find(params[:attendance][:id])
      else
        myAttendance = Attendance.new
      end
      myAttendance.employee_id = params[:attendance][:employee_id]
      myAttendance.timein = params[:attendance][:timein]
      myAttendance.timeout = params[:attendance][:timeout]
      myAttendance.remark = params[:attendance][:remark]
      myAttendance.save!
      flash[:general_flash_notification] = 'Attendance Added'
      flash[:general_flash_notification_type] = 'affirmative'
    rescue => ex
      flash[:general_flash_notification] = 'Error Occurred. Please contact Administrator.'
    end
    redirect_to :action => 'attendances'
  end

  # ================== Rest Days ================== #

  def rest_days
    order_parameter = aggregated_search_queries(params[:order_parameter], 'rest_days', "order_parameter" ,"restdays.created_at")
    order_orientation = aggregated_search_queries(params[:order_orientation], 'rest_days', "order_orientation", "DESC")
    current_limit = aggregated_search_queries(params[:current_limit], 'rest_days', "current_limit","10")
    search_field = aggregated_search_queries(params[:search_field], 'rest_days', "search_field","")
    begin
      @rest_days = Restday
                       .includes(employee: [:actor])
                       .joins(employee: [:actor])
                       .where("actors.name LIKE ? OR restdays.id LIKE ? OR restdays.day LIKE ? OR restdays.created_at LIKE ? OR restdays.updated_at LIKE ?", "%#{search_field}%", "%#{search_field}%","%#{search_field}%","%#{search_field}%","%#{search_field}%" )
                       .order(order_parameter + ' ' + order_orientation)
      @rest_days = Kaminari.paginate_array(@rest_days).page(params[:page]).per(current_limit)
    rescue
      flash[:general_flash_notification] = "Error has Occured"
    end
    render 'human_resources/attendance/rest_days'
  end

  def delete_rest_day
    restDayToBeDeleted = Restday.find(params[:rest_day_id])
    restDayOwner = Employee.find(restDayToBeDeleted.employee_id)
    flash[:general_flash_notification_type] = 'Rest day ' + restDayToBeDeleted.day + ' for employee ' + restDayOwner.actor.name + ' has been deleted.'
    flash[:general_flash_notification_type] = 'affirmative'
    restDayToBeDeleted.destroy
    flash[:general_flash_notification] = 'Rest day ' + restDayToBeDeleted.day + ' for employee ' + restDayOwner.actor.name + ' has been deleted.'
    redirect_to :action => "rest_days"
  end

  # ================== Regular Work Periods ================== #

  def regular_work_periods
    order_parameter = aggregated_search_queries(params[:order_parameter], 'regular_work_periods', "order_parameter" ,"regular_work_periods.created_at")
    order_orientation = aggregated_search_queries(params[:order_orientation], 'regular_work_periods', "order_orientation", "DESC")
    current_limit = aggregated_search_queries(params[:current_limit], 'regular_work_periods', "current_limit","10")
    search_field = aggregated_search_queries(params[:search_field], 'regular_work_periods', "search_field","")

    begin
      @regular_work_periods = RegularWorkPeriod.includes(employee: [:actor])
                                  .joins(employee: [:actor])
                                  .where("actors.name LIKE ? OR regular_work_periods.id LIKE ? OR regular_work_periods.start_time LIKE ? OR regular_work_periods.end_time LIKE ? OR regular_work_periods.remark LIKE ? OR regular_work_periods.created_at LIKE ? OR regular_work_periods.updated_at LIKE ?", "%#{search_field}%", "%#{search_field}%","%#{search_field}%","%#{search_field}%","%#{search_field}%","%#{search_field}%","%#{search_field}%" )
                                  .order(order_parameter + ' ' + order_orientation)
      @regular_work_periods = Kaminari.paginate_array(@regular_work_periods).page(params[:page]).per(current_limit)
    rescue
      flash[:general_flash_notification] = "Error has Occured"
    end
    render 'human_resources/attendance/regular_work_periods'
  end

  def delete_regular_work_period
    regularWorkPeriodToBeDeleted = RegularWorkPeriod.find(params[:regular_work_period_id])
    regularWorkPeriodOwner = Employee.find(regularWorkPeriodToBeDeleted.employee_id)
    flash[:general_flash_notification] = 'Regular work period with Time IN : ' + regularWorkPeriodToBeDeleted.start_time.to_s + ' and Time OUT : ' + regularWorkPeriodToBeDeleted.end_time.to_s + ' for employee ' + regularWorkPeriodOwner.actor.name + ' has been successfully deleted.'
    flash[:general_flash_notification_type] = 'affirmative'
    regularWorkPeriodToBeDeleted.destroy
    redirect_to :action => "regular_work_periods"
  end

  # ================== Lump Sum Adjustments ================== #

  def lump_adjustments
    order_parameter = aggregated_search_queries(params[:order_parameter], 'lump_adjustments', "order_parameter" ,"lump_adjustments.created_at")
    order_orientation = aggregated_search_queries(params[:order_orientation], 'lump_adjustments', "order_orientation", "DESC")
    current_limit = aggregated_search_queries(params[:current_limit], 'lump_adjustments', "current_limit","10")
    search_field = aggregated_search_queries(params[:search_field], 'lump_adjustments', "search_field","")
    begin
      @lump_adjustments = LumpAdjustment.includes(employee: [:actor])
                              .joins(employee: [:actor])
                              .where("actors.name LIKE ? OR lump_adjustments.id LIKE ? OR lump_adjustments.amount LIKE ? OR lump_adjustments.signed_type LIKE ? OR lump_adjustments.remark LIKE ? OR lump_adjustments.date_of_effectivity LIKE ? OR lump_adjustments.created_at LIKE ? OR lump_adjustments.updated_at LIKE ?", "%#{search_field}%", "%#{search_field}%","%#{search_field}%","%#{search_field}%","%#{search_field}%","%#{search_field}%","%#{search_field}%","%#{search_field}%" )
                              .order(order_parameter + ' ' + order_orientation)
      @lump_adjustments = Kaminari.paginate_array(@lump_adjustments).page(params[:page]).per(current_limit)
    rescue
      flash[:general_flash_notification] = "Error has Occured"
    end
    render 'human_resources/compensation_benefits/lump_adjustments'
  end

  def delete_lump_adjustment
    lumpAdjustmentToBeDeleted = LumpAdjustment.find(params[:lump_adjustment_id])
    lumpAdjustmentOwner = Employee.find(lumpAdjustmentToBeDeleted.employee_id)
    flash[:general_flash_notification] = 'Lump adjustment for employee ' + lumpAdjustmentOwner.actor.name + ' has been deleted.'
    flash[:general_flash_notification_type] = 'affirmative'
    lumpAdjustmentToBeDeleted.destroy
    redirect_to :action => "lump_adjustments"
  end

  def search_suggestions_lump_adjustments
    adjustments = LumpAdjustment.includes(employee: :actor).where("employees.id LIKE (?)", "%#{ params[:query] }%").pluck("actors.name")
    direct = "{\"query\": \"Unit\",\"suggestions\":" + adjustments.uniq.to_s + "}"
    respond_to do |format|
      format.all { render :text => direct}
    end
  end

  # ================== Base Rates ================== #

  def base_rates
    order_parameter = aggregated_search_queries(params[:order_parameter], 'base_rates', 'order_parameter' ,'base_rates.created_at')
    order_orientation = aggregated_search_queries(params[:order_orientation], 'base_rates', 'order_orientation', 'DESC')
    current_limit = aggregated_search_queries(params[:current_limit], 'base_rates', 'current_limit','10')
    search_field = aggregated_search_queries(params[:search_field], 'base_rates', 'search_field','')
    begin
      @base_rates = BaseRate.includes(employee: [:actor])
                        .joins(employee: [:actor])
                        .where("actors.name LIKE ? OR base_rates.id LIKE ? OR base_rates.signed_type LIKE ? OR base_rates.signed_type LIKE ? OR base_rates.amount LIKE ? OR base_rates.period_of_time LIKE ? OR base_rates.remark LIKE ? OR base_rates.start_of_effectivity LIKE ? OR base_rates.end_of_effectivity LIKE ? OR base_rates.created_at LIKE ? OR base_rates.updated_at LIKE ?", "%#{search_field}%", "%#{search_field}%","%#{search_field}%","%#{search_field}%","%#{search_field}%","%#{search_field}%","%#{search_field}%","%#{search_field}%","%#{search_field}%","%#{search_field}%","%#{search_field}%" )
                        .order(order_parameter + ' ' + order_orientation)
      @base_rates = Kaminari.paginate_array(@base_rates).page(params[:page]).per(current_limit)
    rescue
      flash[:general_flash_notification] = "Error has Occured"
    end
    render 'human_resources/compensation_benefits/base_rates'
  end

  def delete_base_rate
    baseRateToBeDeleted = BaseRate.find(params[:base_rate_id])
    baseRateOwner = Employee.find(baseRateToBeDeleted.employee_id)
    flash[:general_flash_notification] = baseRateOwner.actor.name + '\'s base rate of ' + baseRateToBeDeleted.amount.to_s + ' per ' + baseRateToBeDeleted.period_of_time + ' has been successfully deleted.'
    flash[:general_flash_notification_type] = 'affirmative'
    baseRateToBeDeleted.destroy
    redirect_to :action => "base_rates"
  end

  def search_suggestions_base_rates
    baseRates = BaseRate.includes(employee: :actor).where("employees.id LIKE (?)", "%#{ params[:query] }%").pluck("actors.name")
    direct = "{\"query\": \"Unit\",\"suggestions\":" + baseRates.uniq.to_s + "}" # default format for plugin
    respond_to do |format|
      format.all { render :text => direct}
    end
  end

  # ================== Constants ================== #

  def constants
    order_parameter = aggregated_search_queries(params[:order_parameter], 'constants', 'order_parameter' ,'constants.created_at')
    order_orientation = aggregated_search_queries(params[:order_orientation], 'constants', 'order_orientation', 'DESC')
    current_limit = aggregated_search_queries(params[:current_limit], 'constants', 'current_limit','10')
    search_field = aggregated_search_queries(params[:search_field], 'constants', 'search_field','')
    begin
      @constants = Constant
                       .where("constants.id LIKE ? OR constants.value LIKE ? OR constants.name LIKE ? OR constants.constant_type LIKE ? OR constants.remark LIKE ? OR constants.created_at LIKE ? OR constants.updated_at LIKE ?", "%#{search_field}%", "%#{search_field}%","%#{search_field}%","%#{search_field}%","%#{search_field}%","%#{search_field}%","%#{search_field}%")
                       .order(order_parameter + ' ' + order_orientation)
      @constants = Kaminari.paginate_array(@constants).page(params[:page]).per(current_limit)
    rescue
      flash[:general_flash_notification] = "Error has Occured"
    end
    render 'human_resources/settings/constants'
  end

  # ================== Holiday ================== #

  def holidays
    order_parameter = aggregated_search_queries(params[:order_parameter], 'holidays', 'order_parameter' ,'constants.created_at')
    order_orientation = aggregated_search_queries(params[:order_orientation], 'holidays', 'order_orientation', 'DESC')
    current_limit = aggregated_search_queries(params[:current_limit], 'holidays', 'current_limit','10')
    search_field = aggregated_search_queries(params[:search_field], 'holidays', 'search_field','')
    begin
      @holidays = Holiday
                      .where("constants.id LIKE ? OR constants.value LIKE ? OR constants.name LIKE ? OR constants.constant_type LIKE ? OR constants.remark LIKE ? OR constants.created_at LIKE ? OR constants.updated_at LIKE ?", "%#{search_field}%", "%#{search_field}%","%#{search_field}%","%#{search_field}%","%#{search_field}%","%#{search_field}%","%#{search_field}%")
                      .order(order_parameter + ' ' + order_orientation)
      @holidays = Kaminari.paginate_array(@holidays).page(params[:page]).per(current_limit)
    rescue
      flash[:general_flash_notification] = "Error has Occured"
    end
    render 'human_resources/settings/constants'
  end

  # ================== Duty Statuses ================== #

  def duty_statuses
    order_parameter = aggregated_search_queries(params[:order_parameter], 'duty_statuses', 'order_parameter' ,'duty_statuses.created_at')
    order_orientation = aggregated_search_queries(params[:order_orientation], 'duty_statuses', 'order_orientation', 'DESC')
    current_limit = aggregated_search_queries(params[:current_limit], 'duty_statuses', 'current_limit','10')
    search_field = aggregated_search_queries(params[:search_field], 'duty_statuses', 'search_field','')
    begin
      @duty_statuses = DutyStatus.includes(employee: [:actor])
                           .joins(employee: [:actor])
                           .where("duty_statuses.id LIKE ? OR duty_statuses.remark LIKE ? OR duty_statuses.active LIKE ? OR actors.name LIKE ? OR duty_statuses.created_at LIKE ? OR duty_statuses.updated_at LIKE ?", "%#{search_field}%", "%#{search_field}%","%#{search_field}%","%#{search_field}%","%#{search_field}%","%#{search_field}%")
                           .order(order_parameter + ' ' + order_orientation)
      @duty_statuses = Kaminari.paginate_array(@duty_statuses).page(params[:page]).per(current_limit)
    rescue
      flash[:general_flash_notification] = "Error has Occured"
    end
    render 'human_resources/attendance/duty_statuses'
  end

  def search_suggestions_employees_with_id
    employees = Employee.includes(:actor).where("actors.name LIKE (?)", "%#{ params[:query] }%").pluck('actors.name', 'id')
    direct = "{\"query\": \"Unit\",\"suggestions\":" + employees.to_s + "}"
    respond_to do |format|
      format.all { render :text => direct}
    end
  end

  def new_duty_status
    initialize_employee_selection
    @selected_duty_status = DutyStatus.new
    render 'human_resources/attendance/duty_status_form'
  end

  def edit_duty_status
    initialize_employee_selection
    @selected_duty_status = DutyStatus.find(params[:duty_status_id])
    render 'human_resources/attendance/duty_status_form'
  end

  def process_duty_status_form
    begin
      if( params[:duty_status][:id].present? )
        myDutyStatus = DutyStatus.find(params[:duty_status][:id])
      else
        myDutyStatus = DutyStatus.new()
      end
      myDutyStatus.active = params[:duty_status][:active]
      myDutyStatus.employee_id = params[:duty_status][:employee_id]
      myDutyStatus.date_of_effectivity = params[:duty_status][:date_of_effectivity]
      myDutyStatus.remark = params[:duty_status][:remark]
      myDutyStatus.save!
      flash[:general_flash_notification] = 'Duty Status Added'
      flash[:general_flash_notification_type] = 'affirmative'
    rescue => ex
      flash[:general_flash_notification] = 'Error Occurred. Please contact Administrator.'
    end
    redirect_to :action => 'duty_statuses'
  end

  # ================== Search Suggestion Queries ================== #

  def search_suggestions_employee_attendances_history
    attendances = Attendance.includes(employee: :actor).where("employees.id LIKE (?)", "%#{ params[:query] }%").pluck("actors.name")
    direct = "{\"query\": \"Unit\",\"suggestions\":" + attendances.uniq.to_s + "}" # default format for plugin
    respond_to do |format|
      format.all { render :text => direct}
    end
  end

  def search_suggestions_branch_attendances
    branchesFromAttendance = Attendance.includes(employee: :branch).where("employees.id LIKE (?)", "%#{ params[:query] }%").pluck("branches.name")
    direct = "{\"query\": \"Unit\",\"suggestions\":" + branchesFromAttendance.uniq.to_s + "}" # default format for plugin
    respond_to do |format|
      format.all { render :text => direct}
    end
  end


  def search_suggestions_advanced_payments_to_employees
    actorNameFromAdvPayment = AdvancedPaymentsToEmployee.includes(employee: :actor).where("employees.id LIKE (?)", "%#{ params[:query] }%").pluck("actors.name")
    direct = "{\"query\": \"Unit\",\"suggestions\":" + actorNameFromAdvPayment.uniq.to_s + "}" # default format for plugin
    respond_to do |format|
      format.all { render :text => direct}
    end
  end

  def search_suggestions_holiday
    holidays = Holiday.includes(:holiday_type).where("holidays.name LIKE (?)", "%#{ params[:query] }%").pluck("holidays.name")
    direct = "{\"query\": \"Unit\",\"suggestions\":" + holidays.uniq.to_s + "}"
    respond_to do |format|
      format.all { render :text => direct}
    end
  end

  # ================== END ================== #

  def assign_duty
    # page data
    @biodatum = Biodatum.find_by_actor_id(params[:actor_id])
    @duties = DutyStatus.all()
    @employee = Employee.find(params[:employee_id])

    @assignedDuty =  DutyStatus.find(params[:duty_dd])
    @assignedDuty.employee_id = @employee.id

    @assignedDuty.save!

    if @assignedDuty.save!
      flash[:general_flash_notification] = 'Duty ' + @assignedDuty.remark + ' was successfully assigned to ' + @employee.actor.name
      flash[:general_flash_notification_type] = 'affirmative'
      render 'human_resources/employee_accounts_management/employee_profile'
    else
      flash[:general_flash_notification] = 'Failed to assign Duty:' + @assignedDuty.remark + ' to ' + @assignedDuty.actor.name
      render 'human_resources/employee_accounts_management/employee_profile'
    end

  end

  def duty_create

    @duties = DutyStatus.page(params[:page]).per(10)
    @employees = Employee.all()
    render 'human_resources/employee_accounts_management/duty_create'
  end

  def create_duty

    @employees = Employee.all()
    @duties = DutyStatus.page(params[:page]).per(10)

    newduty = DutyStatus.new(dutyStatus_params)

    # set duty id to the employee
    # newduty.employee_id = params[:employee_dd]
    # employee = Employee.find(params[:employee_dd])

    if newduty.save!
      flash[:general_flash_notification] = 'Duty ' + newduty.remark + ' was successfully created'
      flash[:general_flash_notification_type] = 'affirmative'
      redirect_to :action => "duty_create"
    else
      flash[:general_flash_notification] = 'Failed to create Duty:' + newduty.remark
      redirect_to :action => "duty_create"
    end

  end



  def assign_duty

    # page data
    @biodatum = Biodatum.find_by_actor_id(params[:actor_id])
    @duties = DutyStatus.all()
    @employee = Employee.find(params[:employee_id])

    @assignedDuty =  DutyStatus.find(params[:duty_dd])
    @assignedDuty.employee_id = @employee.id

    @assignedDuty.save!

    if @assignedDuty.save!
      flash[:general_flash_notification] = 'Duty was successfully assigned to ' + @employee.actor.name
      flash[:general_flash_notification_type] = 'affirmative'
      employee_profile
    else
      flash[:general_flash_notification] = 'Failed to assign Duty to ' + @assignedDuty.actor.name
      employee_profile
    end

  end

  def employee_accounts_data

  end

  def employee_account_history

    # @duties = Duty.where( employee_id: params[:employee][:employee_id] )
    render 'human_resources/employee_accounts_management/employee_account_history'
  end

  def attendance
    render 'human_resources/attendance/index'
  end

  def settings
    @constants = Constant.where( 'name ILIKE ?', "%human_resources%" )
    render 'human_resources/settings/index'
  end

  def institutional_adjustments
    @institutionalAdjustment = InstitutionalAdjustment.all()
    @institutionEmployee = InstitutionEmployee.all()

  end

  def compensation_benefits
    render 'human_resources/compensation_benefits/index'
  end

  def advanced_payments
    @advancedPaymentsToEmployee = AdvancedPaymentsToEmployee.all()
    render 'human_resources/compensation_benefits/advanced_payments'
  end

  def repayments_to_advance_payments
    @advancedPaymentsToEmployee = AdvancedPaymentsToEmployee.all()
    render 'human_resources/compensation_benefits/repayments_to_advance_payments'
  end

  def decision_on_advance_payments
    @advancedPaymentsToEmployee = AdvancedPaymentsToEmployee.all()
    render 'human_resources/compensation_benefits/decision_on_advance_payments'
  end

  def employee_payroll_history(params)

    render 'human_resources/compensation_benefits/employee_payroll_history'
  end

  def printable_format
    render 'human_resources/compensation_benefits/printable_format'
  end

  def edit_employee_page

    # get all necessary employee details
    @branches = Branch.all()
    @employee = Employee.find(params[:employee_id])
    @biodatum = Biodatum.find_by_actor_id(params[:actor_id])
    @actorReference = Actor.find(params[:actor_id])

    render 'human_resources/employee_accounts_management/edit_employee_profile'
  end

  def edit_employee_data

    # find existing employee and biodata using the id from the params
    @employee = Employee.find(params[:employee_id])
    @biodatum = Biodatum.find_by_actor_id(params[:actor_id])
    @actorReference = Actor.find(params[:actor_id])

    # the actual update method passing the parameters set from the pagee
    @biodatum.update_attributes(biodata_params)
    @employee.update_attributes(employee_params)

    branch =  Branch.find(params[:branches_dd])
    @employee.branch_id = branch.id

    # find the existing actor
    actor = Actor.find(params[:actor_id])

    # update the concerned attributes of the actor and assign it back to the objects
    actor.update_attributes(actor_params)

    @employee.actor = actor
    @biodatum.actor = actor

    @biodatum.save!

    if @employee.save && @biodatum.save
      @success_message = 'Successfully edited employee details for ' + @employee.actor.name + '.'
      # render 'human_resources/employee_accounts_management/edit_employee_profile'
      render 'core_partials/employee_registration_success'
    else
      puts 'failed'
      render 'human_resources/employee_accounts_management/edit_employee_profile'
    end

  end

  def register_employee
    actor = Actor.new(actor_params)
    @employee = Employee.new
    @biodata = Biodatum.new(biodata_params)
    @branches = Branch.all()
    branch =  Branch.find(params[:branches_dd])
    @employee.actor = actor
    @employee.branch_id = branch.id
    @biodata.actor = actor
    @biodata.save!
    @employee.save!
    @actorReference = actor

    if @employee.save!
      # Message Constants
      @success_message = 'Successfully registered new employee, ' + @employee.actor.name + '.'
      render 'core_partials/employee_registration_success'
    else
      render 'human_resources/employee_accounts_management/employee_registration'
    end
  end

  private

  def actor_params
    params.require(:actor).permit(:name, :description)
  end

  def employee_params
    params.require(:actor).permit(:actor_id)
  end

  def biodata_params
    params.require(:biodatum)
        .permit(
            :date_of_birth,
            :height,
            :family_members,
            :gender,
            :complexion,
            :marital_status,
            :blood_type,
            :religion,
            :education,
            :career_experience,
            :notable_accomplishments,
            :emergency_contact,
            :languages_spoken
        )
  end

  def dutyStatus_params
    params.require(:dutyStatus)
        .permit(
            :remark,
            :active
        )
  end

  def search_suggestions_branches
    branches = Branch.where("branches.name LIKE (?)", "%#{ params[:query] }%").pluck("branches.name")
    direct = "{\"query\": \"Unit\",\"suggestions\":" + branches.to_s + "}"
    respond_to do |format|
      format.all { render :text => direct}
    end
  end

  def search_suggestions_accesses
    accesses = Access.includes(:actor).where("accesses.username LIKE (?)", "%#{ params[:query] }%").pluck("accesses.username")
    direct = "{\"query\": \"Unit\",\"suggestions\":" + accesses.to_s + "}" # default format for plugin
    respond_to do |format|
      format.all { render :text => direct}
    end
  end

##################################







##################################3


# OLD CODE; PLEASE USE AS REFERENCE

# def candidate_registration
#   idSet = Biodatum.pluck(:actor_id)
#   @accesses = Access.where.not(id: idSet)
# end
#
# def registerCandidate
#   action_redirect = ""
#   id = ""
#   ActiveRecord::Base.transaction do
#       begin
#       processSystemAccount(params)
#       processRelatedFiles(params)
#       processRelatedLinks(params)
#
#       @biodata = Biodatum.new(
#           date_of_birth: params[:biodatum][:birthday],
#           height: params[:biodatum][:height],
#           family_members: params[:biodatum][:family_members],
#           gender: params[:biodatum][:gender],
#           complexion: params[:biodatum][:complexion],
#           marital_status: params[:biodatum][:marital_status],
#           blood_type: params[:biodatum][:blood_type],
#           religion: params[:biodatum][:religion],
#           education: params[:biodatum][:education],
#           career_experience: params[:biodatum][:career_experience],
#           notable_accomplishments: params[:biodatum][:notable_accomplishments],
#           emergency_contact: params[:biodatum][:emergency_contact],
#           languages_spoken: params[:biodatum][:languages_spoken]
#       )
#       @biodata.actor = @actor
#       @biodata.save!
#
#       @employee = Employee.new()
#       @employee.actor = @actor
#       @employee.save!
#
#       processTemporaryEmail(params)
#     end
#   end
# end
#
# def success_candidate_registration
#   access_id = params[:access_id]
#   @nextLink = {
#       0 => {:url => "../home/verification_delivery?access_id=#{access_id}", :label => "Resend Verification"},
#       1 => {:url => "candidate_registration", :label => "Add Another Candidate"},
#       2 => {:url => "employee_status", :label => "Set Service Status of Employees"}
#   }
#   @message = "Candidate may start using account if necessary after email verification completes"
#   @title = "Candidate Registration Successful"
# end
#
# def index
#   @employees = Employee.all()
# end
#
# def employee_profile
# end
#
# def compensation_benefits
#   @employees = Employee.all()
# end
#
# def base_rates
#   getEmployees();
#   @base_rates = BaseRate.where(employee_id: @employee_id)
# end
#
# def lump_adjustments
#   getEmployees();
#   @lump_adjustments = LumpAdjustment.where(employee_id: @employee_id)
# end
#
# def deleteBaseRate
#   baseRateID = params[:base_rate_id]
#   employee_id = params[:employee_id]
#   BaseRate.find(baseRateID).destroy
#   redirect_to  :action => "base_rates", :employee_id => employee_id
# end
#
# def addNewBaseRate
#   action_redirect = "base_rates"
#   employee_id = params[:employee_id]
#
#   ActiveRecord::Base.transaction do
#     begin
#       signed_type = params[:signed_type]
#       amount = params[:amount]
#       period_of_time = params[:period_of_time]
#       start_of_effectivity = DateTime.parse(params[:start_of_effectivity].to_s).strftime("%Y/%m/%d %H:%M:%S")
#       end_of_effectivity = DateTime.parse(params[:end_of_effectivity].to_s).strftime("%Y/%m/%d %H:%M:%S")
#       description = params[:description]
#       if(BaseRate.exists?(params[:base_rate_id]))
#         currentBaseRate = BaseRate.find_by(id: params[:base_rate_id])
#         currentBaseRate.update(signed_type:signed_type, amount:amount, period_of_time:period_of_time, start_of_effectivity:start_of_effectivity, end_of_effectivity:end_of_effectivity,description:description)
#       else
#         currentBaseRate = BaseRate.new(description:description, employee_id:employee_id, signed_type:signed_type, amount:amount, period_of_time:period_of_time, start_of_effectivity:start_of_effectivity, end_of_effectivity:end_of_effectivity )
#         currentBaseRate.save!
#       end
#       flash[:collective_responses] = "Entry Successful!"
#     rescue StandardError => e
#       flash[:collective_responses] = "An error of type #{e.class} happened, message is #{e.message}"
#     end
#   end
#   redirect_to  :action => action_redirect, :employee_id => employee_id
# end
#
# def addLumpAdjustment
#   action_redirect = "lump_adjustments"
#   employee_id = params[:employee_id]
#
#   ActiveRecord::Base.transaction do
#     begin
#       signed_type = params[:signed_type]
#       amount = params[:amount]
#       date_of_effectivity = DateTime.parse(params[:date_of_effectivity].to_s).strftime("%Y/%m/%d %H:%M:%S")
#       description = params[:description]
#       if(LumpAdjustment.exists?(params[:lump_adjustment_id]))
#         currentLumpAdjustment = LumpAdjustment.find_by(id: params[:lump_adjustment_id])
#         currentLumpAdjustment.update(employee_id:employee_id, signed_type:signed_type, amount:amount, date_of_effectivity:date_of_effectivity,description:description)
#       else
#         currentLumpAdjustment = LumpAdjustment.new(description:description, employee_id:employee_id, signed_type:signed_type, amount:amount, date_of_effectivity:date_of_effectivity, )
#         currentLumpAdjustment.save!
#       end
#       flash[:collective_responses] = "Entry Successful!"
#     rescue StandardError => e
#       flash[:collective_responses] = "An error of type #{e.class} happened, message is #{e.message}"
#     end
#   end
#   redirect_to  :action => action_redirect, :employee_id => employee_id
# end
#
# def deleteLumpAdjustment
#   lumpAdjustmentID = params[:lump_adjustment_id]
#   employee_id = params[:employee_id]
#   LumpAdjustment.find(lumpAdjustmentID).destroy
#   redirect_to  :action => "lump_adjustments", :employee_id => employee_id
# end

end
