class HumanResourcesController < ApplicationController
  include ApplicationHelper

  layout "application_loggedin"

  def index
    render 'human_resources/index'
  end

  # ================== Lump Sum Adjustments ================== #

  def lump_adjustments
    query = generic_table_aggregated_queries('lump_adjustments','lump_adjustments.created_at')
    begin
      @lump_adjustments = LumpAdjustment
                              .includes(employee: [:actor])
                              .joins(employees: [:actor])
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
    flash[:general_flash_notification] = 'Lump adjustment for employees ' + lumpAdjustmentOwner.actor.name + ' has been deleted.'
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



  # ================== Holiday Types ================== #

  def edit_holiday_type
    @selected_holiday_type = HolidayType.find(params[:holiday_type_id])
    render 'human_resources/settings/holiday_type_form'
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

    # set duty id to the employees
    # newduty.employee_id = params[:employee_dd]
    # employees = Employee.find(params[:employee_dd])

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

    # @duties = Duty.where( employee_id: params[:employees][:employee_id] )
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

    # get all necessary employees details
    @branches = Branch.all()
    @employee = Employee.find(params[:employee_id])
    @biodatum = Biodatum.find_by_actor_id(params[:actor_id])
    @actorReference = Actor.find(params[:actor_id])

    render 'human_resources/employee_accounts_management/edit_employee_profile'
  end

  def edit_employee_data

    # find existing employees and biodata using the id from the params
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
      @success_message = 'Successfully edited employees details for ' + @employee.actor.name + '.'
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
      @success_message = 'Successfully registered new employees, ' + @employee.actor.name + '.'
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
  #   dutyStatuses = DutyStatus.includes(employees: :actor).where("actors.name LIKE (?)", "%#{ params[:query] }%").pluck("actors.name")
  #   direct = "{\"query\": \"Unit\",\"suggestions\":" + dutyStatuses.uniq.to_s + "}"
  #   respond_to do |format|
  #     format.all { render :text => direct}
  #   end
  # end
  #
  # def search_suggestions_employee_attendances_history
  #   attendances = Attendance.includes(employees: :actor).where("employees.id LIKE (?)", "%#{ params[:query] }%").pluck("actors.name")
  #   direct = "{\"query\": \"Unit\",\"suggestions\":" + attendances.uniq.to_s + "}" # default format for plugin
  #   respond_to do |format|
  #     format.all { render :text => direct}
  #   end
  # end
  #
  # def search_suggestions_branch_attendances
  #   branchesFromAttendance = Attendance.includes(employees: :branch).where("employees.id LIKE (?)", "%#{ params[:query] }%").pluck("branches.name")
  #   direct = "{\"query\": \"Unit\",\"suggestions\":" + branchesFromAttendance.uniq.to_s + "}" # default format for plugin
  #   respond_to do |format|
  #     format.all { render :text => direct}
  #   end
  # end
  #
  #
  # def search_suggestions_advanced_payments_to_employees
  #   actorNameFromAdvPayment = AdvancedPaymentsToEmployee.includes(employees: :actor).where("employees.id LIKE (?)", "%#{ params[:query] }%").pluck("actors.name")
  #   direct = "{\"query\": \"Unit\",\"suggestions\":" + actorNameFromAdvPayment.uniq.to_s + "}" # default format for plugin
  #   respond_to do |format|
  #     format.all { render :text => direct}
  #   end
  # end
end
