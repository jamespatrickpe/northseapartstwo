class HumanResources::EmployeeAccountsManagement::DutyStatusesController < HumanResources::EmployeeAccountsManagementController

  def index
    query = generic_table_aggregated_queries('duty_statuses','duty_statuses.created_at')
    begin
      @duty_statuses = DutyStatus.includes(employee: [:actor])
                           .joins(employees: [:actor])
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

  def new
    initialize_employee_selection
    @selected_duty_status = DutyStatus.new
    render 'human_resources/employee_accounts_management/duty_status_form'
  end

  def edit
    initialize_employee_selection
    @selected_duty_status = DutyStatus.find(params[:duty_status_id])
    render 'human_resources/employee_accounts_management/duty_status_form'
  end

  def delete
    dutyStatusToBeDeleted = DutyStatus.find(params[:duty_status_id])
    dutyStatusOwner = Employee.find(dutyStatusToBeDeleted.employee_id)
    flash[:general_flash_notification] = 'A Duty status for ' + dutyStatusOwner.actor.name + ' has been deleted.'
    flash[:general_flash_notification_type] = 'affirmative'
    dutyStatusToBeDeleted.destroy
    redirect_to :action => "duty_statuses"
  end

  def process_duty_status_form(myDutyStatus)
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

  def create
    myDutyStatus = DutyStatus.new()
    flash[:general_flash_notification] = 'Duty Status Added!'
    process_duty_status_form(myDutyStatus)
  end

  def update
    myDutyStatus = DutyStatus.find(params[:duty_status][:id])
    flash[:general_flash_notification] = 'Duty Status Updated!'
    process_duty_status_form(myDutyStatus)
  end

end
