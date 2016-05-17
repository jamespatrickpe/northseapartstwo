class HumanResources::EmployeeAccountsManagement::DutyStatusesController < HumanResources::EmployeeAccountsManagementController

  def index
    query = generic_index_aggregated_queries('duty_statuses','duty_statuses.created_at')
    begin
      @duty_statuses = DutyStatus.includes(employee: [:system_actor])
                           .joins(employee: [:system_actors])
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
    rescue => ex
      flash[:general_flash_notification] = "Error has Occured"
    end
    render 'human_resources/employee_accounts_management/duty_statuses/index'
  end

  def initialize_form
    initialize_form_variables('DUTY STATUS FORM',
                              'human_resources/employee_accounts_management/duty_statuses/duty_status_form',
                              'duty_status')
    initialize_employee_selection
  end

  def new
    initialize_form
    @selected_duty_status = DutyStatus.new
    generic_bicolumn_form_with_employee_selection(@selected_duty_status)
  end

  def edit
    initialize_form
    @selected_duty_status = DutyStatus.find(params[:id])
    generic_bicolumn_form_with_employee_selection(@selected_duty_status)
  end

  def delete
    generic_delete_model(DutyStatus,controller_name)
  end

  def search_suggestions
    generic_employee_name_search_suggestions(DutyStatus)
  end

  def process_duty_status_form(myDutyStatus)
    begin
      myDutyStatus.active = params[:duty_status][:active]
      myDutyStatus.employee_id = params[:duty_status][:employee_id]
      myDutyStatus.date_of_implementation = params[:duty_status][:date_of_implementation]
      myDutyStatus.remark = params[:duty_status][:remark]
      myDutyStatus.save!
      flash[:general_flash_notification_type] = 'affirmative'
    rescue => ex
      flash[:general_flash_notification] = 'Error Occurred. Please contact Administrator.'
    end
    redirect_to :action => 'index'
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
