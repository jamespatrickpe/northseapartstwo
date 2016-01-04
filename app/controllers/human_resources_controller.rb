class HumanResourcesController < ApplicationController
  include ApplicationHelper

  layout "application_loggedin"

  def index
    render 'human_resources/index'
  end

  def attendance
    render 'human_resources/attendance/index'
  end

  def compensation_and_benefits
    render 'human_resources/compensation_benefits/index'
  end


  def employee_accounts_management
    render 'human_resources/employee_accounts_management/index'
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
    render 'human_resources/employee_accounts_management/employees'
  end

  def employee_registration
    @branches = Branch.all()
    render 'human_resources/employee_accounts_management/employee_registration'
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

  def attendances
    query = generic_table_aggregated_queries('attendances','attendances.created_at')
    begin
      @attendances = Attendance
      .includes(employee: [:actor])
      .joins(employee: [:actor])
      .where("actors.name LIKE ? OR " +
             "attendances.id LIKE ? OR " +
             "attendances.timein LIKE ? OR " +
             "attendances.timeout LIKE ? OR " +
             "attendances.remark LIKE ? OR " +
             "attendances.updated_at LIKE ? OR " +
             "attendances.created_at LIKE ?",
             "%#{query[:search_field]}%",
             "%#{query[:search_field]}%",
             "%#{query[:search_field]}%",
             "%#{query[:search_field]}%",
             "%#{query[:search_field]}%",
             "%#{query[:search_field]}%",
             "%#{query[:search_field]}%")
      .order(query[:order_parameter] + ' ' + query[:order_orientation])
      @attendances = Kaminari.paginate_array(@attendances).page(params[:page]).per(query[:current_limit])
    rescue => ex
      flash[:general_flash_notification] = "Error has Occured"
    end
    render 'human_resources/attendance/attendances'
  end

  def delete_attendance
    attendaceToBeDeleted = Attendance.find(params[:attendance_id])
    attendanceOwner = Employee.find(attendaceToBeDeleted.employee_id)
    flash[:general_flash_notification] = 'Attendance for ' + attendanceOwner.actor.name + ' has been deleted.'
    flash[:general_flash_notification_type] = 'affirmative'
    attendaceToBeDeleted.destroy
    redirect_to :action => "attendances"
  end

  def branch_attendance_sheet
    @branches = Branch.all
    begin
    if params[:branch].present? && params[:start_date].present? && params[:end_date].present?
      @start_date = DateTime.strptime(params[:start_date],"%Y-%m-%d")
      @end_date = DateTime.strptime(params[:end_date],"%Y-%m-%d")
      @number_of_days = (@end_date - @start_date).abs.to_i + 1
      @selected_branch = Branch.find(params[:branch][:id])
      @employees_by_branch = Employee
                                 .includes(:actor, :duty_status)
                                 .joins(:actor, :duty_status)
                                 .where("branch_id = ?", "#{@selected_branch.id}")
      @attendances_per_employee_in_branch = Attendance.includes(:employee).joins(:employee).where("employees.branch_id = ?", "#{@selected_branch.id}")
    end
    @selected_branch ||= Branch.new
    rescue
      flash[:general_flash_notification] = "Error has Occurred"
    end
    render 'human_resources/attendance/branch_attendance_sheet'
  end

  def check_time_between_employee(attendance_time, employee)
  end

  def process_branch_attendance_sheet
    branch_id = params[:branch][:id]
    start_date = params[:start_date]
    end_date = params[:end_date]
    flash[:general_flash_notification] = 'Attendance (if any) has been recorded.'
    flash[:general_flash_notification_type] = 'Affirmative'
    Attendance.transaction do
      begin
        total_items = params[:total_items].to_i
        total_items.times do |i|
          if params[:attendance][i.to_s][:timein].present? || params[:attendance][i.to_s][:timeout].present?
            myAttendance = Attendance.new
            myDate = Date.strptime(params[:attendance][i.to_s][:date],"%F")
            if params[:attendance][i.to_s][:timein].present?
              myTimeIn = Time.parse(params[:attendance][i.to_s][:timein], myDate)
              timein = DateTime.new( myDate.year, myDate.month, myDate.day, myTimeIn.hour, myTimeIn.min, myTimeIn.sec, "+8")
              myAttendance.timein = timein
            end
            if params[:attendance][i.to_s][:timeout].present?
              myTimeOut = Time.parse(params[:attendance][i.to_s][:timeout], myDate)
              timeout = DateTime.new( myDate.year, myDate.month, myDate.day, myTimeOut.hour, myTimeOut.min, myTimeOut.sec, "+8" )
              myAttendance.timeout = timeout
            end
            similar_attendances = Attendance.where("(employee_id = ?) AND (date_of_attendance = ?)", "#{params[:attendance][i.to_s][:employee_id]}", "#{myDate.strftime("%Y-%m-%d")}")
            similar_attendances.each do | similar_attendance |
                similar_attendance_timein = insertTimeIntoDate(myDate, similar_attendance[:timein])
                similar_attendance_timeout = insertTimeIntoDate(myDate, similar_attendance[:timeout])
                actor_name = params[:attendance][i.to_s][:employee_actor_name]
                date_conflict = myDate.month.to_s + '/' + myDate.day.to_s + '/' + myDate.year.to_s
                if timein.between?(similar_attendance_timein, similar_attendance_timeout) || timeout.between?(similar_attendance_timein, similar_attendance_timeout)
                  raise 'No Attendance has been recorded; Time Conflict for ' + actor_name +  ' on the date of ' + date_conflict
                elsif (timein..timeout).overlaps?(similar_attendance_timein..similar_attendance_timeout)
                  raise 'No Attendance has been recorded; Overlap Conflict for ' + actor_name +  ' on the date of ' + date_conflict
                elsif timein.to_i > timeout.to_i
                  raise 'No Attendance has been recorded; Time In is more than Time Out for ' + actor_name +  ' on the date of ' + date_conflict
                else
                end
            end
            myAttendance.date_of_attendance = myDate
            myAttendance.employee_id = params[:attendance][i.to_s][:employee_id]
            myAttendance.remark = params[:attendance][i.to_s][:remark]
            myAttendance.save!
          end
        end
      rescue => ex
        ex.message.present? ? flash[:general_flash_notification] = ex.message : flash[:general_flash_notification] = 'Error has Occurred; Please Contact Administrator'
      end
    end
    redirect_to :action => 'branch_attendance_sheet', :branch => {:id => branch_id}, :start_date => start_date, :end_date => end_date
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
      myAttendance.date_of_attendance = params[:attendance][:date_of_attendance]
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
    query = generic_table_aggregated_queries('rest_days','rest_days.created_at')
    begin
      @rest_days = RestDay
                       .includes(employee: [:actor])
                       .joins(employee: [:actor])
                       .where("actors.name LIKE ? OR " +
                              "rest_days.id LIKE ? OR " +
                              "rest_days.day LIKE ? OR " +
                              "rest_days.created_at LIKE ? OR " +
                              "rest_days.updated_at LIKE ? ",
                              "%#{query[:search_field]}%",
                              "%#{query[:search_field]}%",
                              "%#{query[:search_field]}%",
                              "%#{query[:search_field]}%",
                              "%#{query[:search_field]}%")
                       .order(query[:order_parameter] + ' ' + query[:order_orientation])
      @rest_days = Kaminari.paginate_array(@rest_days).page(params[:page]).per(query[:current_limit])
    rescue => ex
      flash[:general_flash_notification] = "Error has Occured" + ex.to_s
    end
    render 'human_resources/attendance/rest_days'
  end

  def search_suggestions_rest_days
    restdays = RestDay.includes(employee: :actor).where("actors.name LIKE (?)", "%#{ params[:query] }%").pluck("actors.name")
    direct = "{\"query\": \"Unit\",\"suggestions\":" + restdays.uniq.to_s + "}"
    respond_to do |format|
      format.all { render :text => direct}
    end
  end

  def delete_rest_day
    restDayToBeDeleted = RestDay.find(params[:rest_day_id])
    restDayOwner = Employee.find(restDayToBeDeleted.employee_id)
    flash[:general_flash_notification_type] = 'Rest day ' + restDayToBeDeleted.day + ' for employee ' + restDayOwner.actor.name + ' has been deleted.'
    flash[:general_flash_notification_type] = 'affirmative'
    restDayToBeDeleted.destroy
    flash[:general_flash_notification] = 'Rest day ' + restDayToBeDeleted.day + ' for employee ' + restDayOwner.actor.name + ' has been deleted.'
    redirect_to :action => "rest_days"
  end

  def new_rest_day
    initialize_employee_selection
    @selected_rest_day = RestDay.new
    render 'human_resources/attendance/rest_day_form'
  end

  def edit_rest_day
    initialize_employee_selection
    @selected_rest_day = RestDay.find(params[:rest_day_id])
    render 'human_resources/attendance/rest_day_form'
  end

  def process_rest_day_form
    begin
      if( params[:rest_day][:id].present? )
        restDay = RestDay.find(params[:rest_day][:id])
      else
        restDay = RestDay.new()
      end
      restDay.id = params[:rest_day][:id]
      restDay.day = params[:rest_day][:day]
      restDay.date_of_effectivity = params[:rest_day][:date_of_effectivity]
      restDay.employee = Employee.find(params[:rest_day][:employee_id])
      restDay.save!
      flash[:general_flash_notification] = 'Rest Day Added'
      flash[:general_flash_notification_type] = 'affirmative'
    rescue => ex
      flash[:general_flash_notification] = 'Error Occurred. Please contact Administrator.' + ex.to_s
    end
    redirect_to :action => 'rest_days'
  end

  # ================== Regular Work Periods ================== #

  def regular_work_periods
    query = generic_table_aggregated_queries('regular_work_periods','regular_work_periods.created_at')
    begin
      @regular_work_periods = RegularWorkPeriod
                                  .includes(employee: [:actor])
                                  .joins(employee: [:actor])
                                  .where("actors.name LIKE ? OR " +
                                         "regular_work_periods.id LIKE ? OR " +
                                         "regular_work_periods.start_time LIKE ? OR " +
                                         "regular_work_periods.end_time LIKE ? OR " +
                                         "regular_work_periods.remark LIKE ? OR " +
                                         "regular_work_periods.created_at LIKE ? OR " +
                                         "regular_work_periods.updated_at LIKE ?",
                                         "%#{query[:search_field]}%",
                                         "%#{query[:search_field]}%",
                                         "%#{query[:search_field]}%",
                                         "%#{query[:search_field]}%",
                                         "%#{query[:search_field]}%",
                                         "%#{query[:search_field]}%",
                                         "%#{query[:search_field]}%" )
                                  .order(query[:order_parameter] + ' ' + query[:order_orientation])
      @regular_work_periods = Kaminari.paginate_array(@regular_work_periods).page(params[:page]).per(query[:current_limit])
    rescue
      flash[:general_flash_notification] = "Error has Occured"
    end
    render 'human_resources/attendance/regular_work_periods'
  end

  def search_suggestions_regular_work_periods
    regularWorkPeriods = RegularWorkPeriod.includes(employee: :actor).where("actors.name LIKE (?)", "%#{ params[:query] }%").pluck("actors.name")
    direct = "{\"query\": \"Unit\",\"suggestions\":" + regularWorkPeriods.uniq.to_s + "}"
    respond_to do |format|
      format.all { render :text => direct}
    end
  end

  def delete_regular_work_period
    regularWorkPeriodToBeDeleted = RegularWorkPeriod.find(params[:regular_work_period_id])
    regularWorkPeriodOwner = Employee.find(regularWorkPeriodToBeDeleted.employee_id)
    flash[:general_flash_notification] = 'Regular work period with Time IN : ' + regularWorkPeriodToBeDeleted.start_time.to_s + ' and Time OUT : ' + regularWorkPeriodToBeDeleted.end_time.to_s + ' for employee ' + regularWorkPeriodOwner.actor.name + ' has been successfully deleted.'
    flash[:general_flash_notification_type] = 'affirmative'
    regularWorkPeriodToBeDeleted.destroy
    redirect_to :action => "regular_work_periods"
  end

  def new_regular_work_period
    initialize_employee_selection
    @selected_regular_work_period = RegularWorkPeriod.new
    render 'human_resources/attendance/regular_work_period_form'
  end

  def edit_regular_work_period
    initialize_employee_selection
    @selected_regular_work_period = RegularWorkPeriod.find(params[:regular_work_period_id])
    render 'human_resources/attendance/regular_work_period_form'
  end

  def process_regular_work_period_form
    begin
      if( params[:regular_work_period][:id].present? )
        regularWorkPeriod = RegularWorkPeriod.find(params[:regular_work_period][:id])
      else
        regularWorkPeriod = RegularWorkPeriod.new()
      end
      regularWorkPeriod.employee = Employee.find(params[:regular_work_period][:employee_id])
      regularWorkPeriod.start_time = params[:regular_work_period][:start_time]
      regularWorkPeriod.end_time = params[:regular_work_period][:end_time]
      regularWorkPeriod.date_of_effectivity = params[:regular_work_period][:date_of_effectivity]
      regularWorkPeriod.remark = params[:regular_work_period][:remark]
      regularWorkPeriod.save!
      flash[:general_flash_notification] = 'Regular Work Period Added'
      flash[:general_flash_notification_type] = 'affirmative'
    rescue => ex
      puts ex
      flash[:general_flash_notification] = 'Error Occurred. Please contact Administrator.'
    end
    redirect_to :action => 'regular_work_periods'
  end


  # ================== Lump Sum Adjustments ================== #

  def lump_adjustments
    query = generic_table_aggregated_queries('lump_adjustments','lump_adjustments.created_at')
    begin
      @lump_adjustments = LumpAdjustment
                              .includes(employee: [:actor])
                              .joins(employee: [:actor])
                              .where("actors.name LIKE ? OR " +
                                     "lump_adjustments.id LIKE ? OR " +
                                     "lump_adjustments.amount LIKE ? OR " +
                                     "lump_adjustments.signed_type LIKE ? OR " +
                                     "lump_adjustments.remark LIKE ? OR " +
                                     "lump_adjustments.date_of_effectivity LIKE ? OR " +
                                     "lump_adjustments.created_at LIKE ? OR " +
                                     "lump_adjustments.updated_at LIKE ?",
                                     "%#{query[:search_field]}%",
                                     "%#{query[:search_field]}%",
                                     "%#{query[:search_field]}%",
                                     "%#{query[:search_field]}%",
                                     "%#{query[:search_field]}%",
                                     "%#{query[:search_field]}%",
                                     "%#{query[:search_field]}%",
                                     "%#{query[:search_field]}%")
                              .order(query[:order_parameter] + ' ' + query[:order_orientation])
      @lump_adjustments = Kaminari.paginate_array(@lump_adjustments).page(params[:page]).per(query[:current_limit])
    rescue
      flash[:general_flash_notification] = "Error has Occured"
    end
    render 'human_resources/compensation_benefits/lump_adjustments'
  end

  def search_suggestions_lump_adjustments
    adjustments = LumpAdjustment.includes(employee: :actor).where("actors.name LIKE (?)", "%#{ params[:query] }%").pluck("actors.name")
    direct = "{\"query\": \"Unit\",\"suggestions\":" + adjustments.uniq.to_s + "}"
    respond_to do |format|
      format.all { render :text => direct}
    end
  end

  def delete_lump_adjustment
    lumpAdjustmentToBeDeleted = LumpAdjustment.find(params[:lump_adjustment_id])
    lumpAdjustmentOwner = Employee.find(lumpAdjustmentToBeDeleted.employee_id)
    flash[:general_flash_notification] = 'Lump adjustment for employee ' + lumpAdjustmentOwner.actor.name + ' has been deleted.'
    flash[:general_flash_notification_type] = 'affirmative'
    lumpAdjustmentToBeDeleted.destroy
    redirect_to :action => "lump_adjustments"
  end

  def new_lump_adjustment
    initialize_employee_selection
    @selected_lump_adjustment = LumpAdjustment.new
    render 'human_resources/compensation_benefits/lump_adjustment_form'
  end

  def edit_lump_adjustment
    initialize_employee_selection
    @selected_lump_adjustment = LumpAdjustment.find(params[:lump_adjustment_id])
    render 'human_resources/compensation_benefits/lump_adjustment_form'
  end

  def process_lump_adjustment_form
    begin
      if( params[:lump_adjustment][:id].present? )
        lumpAdjustment = LumpAdjustment.find(params[:lump_adjustment][:id])
      else
        lumpAdjustment = LumpAdjustment.new()
      end
      lumpAdjustment.id = params[:lump_adjustment][:id]
      lumpAdjustment.amount = params[:lump_adjustment][:amount]
      lumpAdjustment.employee_id = params[:lump_adjustment][:employee_id]
      lumpAdjustment.signed_type = params[:lump_adjustment][:signed_type]
      lumpAdjustment.remark = params[:lump_adjustment][:remark]
      lumpAdjustment.date_of_effectivity = params[:lump_adjustment][:date_of_effectivity]
      lumpAdjustment.save!
      flash[:general_flash_notification] = 'Lump Adjustment Added'
      flash[:general_flash_notification_type] = 'affirmative'
    rescue => ex
      puts ex
      flash[:general_flash_notification] = 'Error Occurred. Please contact Administrator.'
    end
    redirect_to :action => 'lump_adjustments'
  end

  # ================== Base Rates ================== #

  def base_rates
    query = generic_table_aggregated_queries('base_rates','base_rates.created_at')
    begin
      @base_rates = BaseRate.includes(employee: [:actor])
                        .joins(employee: [:actor])
                        .where("actors.name LIKE ? OR " +
                               "base_rates.id LIKE ? OR " +
                               "base_rates.signed_type LIKE ? OR " +
                               "base_rates.signed_type LIKE ? OR " +
                               "base_rates.amount LIKE ? OR " +
                               "base_rates.period_of_time LIKE ? OR " +
                               "base_rates.remark LIKE ? OR " +
                               "base_rates.start_of_effectivity LIKE ? OR " +
                               "base_rates.end_of_effectivity LIKE ? OR " +
                               "base_rates.created_at LIKE ? OR " +
                               "base_rates.updated_at LIKE ?",
                               "%#{query[:search_field]}%",
                               "%#{query[:search_field]}%",
                               "%#{query[:search_field]}%",
                               "%#{query[:search_field]}%",
                               "%#{query[:search_field]}%",
                               "%#{query[:search_field]}%",
                               "%#{query[:search_field]}%",
                               "%#{query[:search_field]}%",
                               "%#{query[:search_field]}%",
                               "%#{query[:search_field]}%",
                               "%#{query[:search_field]}%")
                        .order(query[:order_parameter] + ' ' + query[:order_orientation])
      @base_rates = Kaminari.paginate_array(@base_rates).page(params[:page]).per(query[:current_limit])
    rescue
      flash[:general_flash_notification] = "Error has Occured"
    end
    render 'human_resources/compensation_benefits/base_rates'
  end

  def search_suggestions_base_rates
    baseRates = BaseRate.includes(employee: :actor).where("actors.name LIKE (?)", "%#{ params[:query] }%").pluck("actors.name")
    direct = "{\"query\": \"Unit\",\"suggestions\":" + baseRates.uniq.to_s + "}" # default format for plugin
    respond_to do |format|
      format.all { render :text => direct}
    end
  end

  def new_base_rate
    initialize_employee_selection
    @selected_base_rate = BaseRate.new
    render 'human_resources/compensation_benefits/base_rate_form'
  end

  def edit_base_rate
    initialize_employee_selection
    @selected_base_rate = BaseRate.find(params[:base_rate_id])
    render 'human_resources/compensation_benefits/base_rate_form'
  end

  def process_base_rate_form
    begin
      if( params[:base_rate][:id].present? )
        puts 'inside if ==================================== a'
        baseRate = BaseRate.find(params[:base_rate][:id])
      else
        baseRate = BaseRate.new()
        puts 'inside else ==================================== b '
      end
      baseRate.employee_id = params[:base_rate][:employee_id]
      employee = Employee.find(params[:base_rate][:employee_id])
      baseRate.employee = employee
      baseRate.signed_type = params[:base_rate][:signed_type]
      baseRate.amount = params[:base_rate][:amount]
      baseRate.period_of_time = params[:base_rate][:period_of_time]
      baseRate.rate_type = params[:base_rate][:rate_type]
      baseRate.remark = params[:base_rate][:remark]
      baseRate.start_of_effectivity = params[:base_rate][:start_of_effectivity]
      baseRate.end_of_effectivity = params[:base_rate][:end_of_effectivity]
      baseRate.save!
      flash[:general_flash_notification] = 'Base Rate Added'
      flash[:general_flash_notification_type] = 'affirmative'
    rescue => ex
      puts ex
      flash[:general_flash_notification] = 'Error Occurred. Please contact Administrator.'
    end
    redirect_to :action => 'base_rates'
  end

  def delete_base_rate
    baseRateToBeDeleted = BaseRate.find(params[:base_rate_id])
    baseRateOwner = Employee.find(baseRateToBeDeleted.employee_id)
    flash[:general_flash_notification] = baseRateOwner.actor.name + '\'s base rate of ' + baseRateToBeDeleted.amount.to_s + ' per ' + baseRateToBeDeleted.period_of_time + ' has been successfully deleted.'
    flash[:general_flash_notification_type] = 'affirmative'
    baseRateToBeDeleted.destroy
    redirect_to :action => "base_rates"
  end

  # ================== Vales ================== #

  def vales

  end

  # ================== Holiday Types ================== #

  def edit_holiday_type
    @selected_holiday_type = HolidayType.find(params[:holiday_type_id])
    render 'human_resources/settings/holiday_type_form'
  end

  # ================== Duty Statuses ================== #

  def duty_statuses
    query = generic_table_aggregated_queries('duty_statuses','duty_statuses.created_at')
    begin
      @duty_statuses = DutyStatus.includes(employee: [:actor])
                           .joins(employee: [:actor])
                           .where("duty_statuses.id LIKE ? OR " +
                                  "duty_statuses.remark LIKE ? OR " +
                                  "duty_statuses.active LIKE ? OR " +
                                  "actors.name LIKE ? OR " +
                                  "duty_statuses.created_at LIKE ? OR " +
                                  "duty_statuses.updated_at LIKE ?",
                                  "%#{query[:search_field]}%",
                                  "%#{query[:search_field]}%",
                                  "%#{query[:search_field]}%",
                                  "%#{query[:search_field]}%",
                                  "%#{query[:search_field]}%",
                                  "%#{query[:search_field]}%")
                           .order(query[:order_parameter] + ' ' + query[:order_orientation])
      @duty_statuses = Kaminari.paginate_array(@duty_statuses).page(params[:page]).per(query[:current_limit])
    rescue
      flash[:general_flash_notification] = "Error has Occured"
    end
    render 'human_resources/employee_accounts_management/duty_statuses'
  end

  def new_duty_status
    initialize_employee_selection
    @selected_duty_status = DutyStatus.new
    render 'human_resources/employee_accounts_management/duty_status_form'
  end

  def edit_duty_status
    initialize_employee_selection
    @selected_duty_status = DutyStatus.find(params[:duty_status_id])
    render 'human_resources/employee_accounts_management/duty_status_form'
  end

  def delete_duty_status
    dutyStatusToBeDeleted = DutyStatus.find(params[:duty_status_id])
    dutyStatusOwner = Employee.find(dutyStatusToBeDeleted.employee_id)
    flash[:general_flash_notification] = 'A Duty status for ' + dutyStatusOwner.actor.name + ' has been deleted.'
    flash[:general_flash_notification_type] = 'affirmative'
    dutyStatusToBeDeleted.destroy
    redirect_to :action => "duty_statuses"
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

  # def search_suggestions_branches
  #   branches = Branch.where("branches.name LIKE (?)", "%#{ params[:query] }%").pluck("branches.name")
  #   direct = "{\"query\": \"Unit\",\"suggestions\":" + branches.to_s + "}"
  #   respond_to do |format|
  #     format.all { render :text => direct}
  #   end
  # end
  #
  # def search_suggestions_accesses
  #   accesses = Access.includes(:actor).where("accesses.username LIKE (?)", "%#{ params[:query] }%").pluck("accesses.username")
  #   direct = "{\"query\": \"Unit\",\"suggestions\":" + accesses.to_s + "}" # default format for plugin
  #   respond_to do |format|
  #     format.all { render :text => direct}
  #   end
  # end
  #
  #
  # def search_suggestions_employees
  #   employees = Employee.includes(:actor).where("actors.name LIKE (?)", "%#{ params[:query] }%").pluck("actors.name")
  #   direct = "{\"query\": \"Unit\",\"suggestions\":" + employees.to_s + "}"
  #   respond_to do |format|
  #     format.all { render :text => direct}
  #   end
  # end
  #
  # def search_suggestions_employees_with_id
  #   employees = Employee.includes(:actor).where("actors.name LIKE (?)", "%#{ params[:query] }%").pluck('actors.name', 'id')
  #   direct = "{\"query\": \"Unit\",\"suggestions\":" + employees.to_s + "}"
  #   respond_to do |format|
  #     format.all { render :text => direct}
  #   end
  # end
  #
  # def search_suggestions_duty_statuses
  #   dutyStatuses = DutyStatus.includes(employee: :actor).where("actors.name LIKE (?)", "%#{ params[:query] }%").pluck("actors.name")
  #   direct = "{\"query\": \"Unit\",\"suggestions\":" + dutyStatuses.uniq.to_s + "}"
  #   respond_to do |format|
  #     format.all { render :text => direct}
  #   end
  # end
  #
  # def search_suggestions_employee_attendances_history
  #   attendances = Attendance.includes(employee: :actor).where("employees.id LIKE (?)", "%#{ params[:query] }%").pluck("actors.name")
  #   direct = "{\"query\": \"Unit\",\"suggestions\":" + attendances.uniq.to_s + "}" # default format for plugin
  #   respond_to do |format|
  #     format.all { render :text => direct}
  #   end
  # end
  #
  # def search_suggestions_branch_attendances
  #   branchesFromAttendance = Attendance.includes(employee: :branch).where("employees.id LIKE (?)", "%#{ params[:query] }%").pluck("branches.name")
  #   direct = "{\"query\": \"Unit\",\"suggestions\":" + branchesFromAttendance.uniq.to_s + "}" # default format for plugin
  #   respond_to do |format|
  #     format.all { render :text => direct}
  #   end
  # end
  #
  #
  # def search_suggestions_advanced_payments_to_employees
  #   actorNameFromAdvPayment = AdvancedPaymentsToEmployee.includes(employee: :actor).where("employees.id LIKE (?)", "%#{ params[:query] }%").pluck("actors.name")
  #   direct = "{\"query\": \"Unit\",\"suggestions\":" + actorNameFromAdvPayment.uniq.to_s + "}" # default format for plugin
  #   respond_to do |format|
  #     format.all { render :text => direct}
  #   end
  # end
end
