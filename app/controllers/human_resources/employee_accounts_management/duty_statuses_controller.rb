class HumanResources::EmployeeAccountsManagement::DutyStatusesController < HumanResources::EmployeeAccountsManagementController

  def index
    initialize_generic_index(DutyStatus, 'Current Status of an Employee')
  end

  def search_suggestions
    generic_index_search_suggestions(DutyStatus)
  end

  def new
    set_new_edit(DutyStatus)
  end

  def edit
    set_new_edit(DutyStatus)
  end

  def show
    edit
  end

  def delete
    generic_delete(DutyStatus)
  end

  def process_form(my_duty_status, current_params, wizard_mode = nil)
    begin
      my_duty_status.employee_id = current_params[:employee_id]
      my_duty_status.branch_id = current_params[:branch_id]
      my_duty_status.active = current_params[:active]
      my_duty_status.remark = current_params[:remark]
      my_duty_status.save!
      set_process_notification(current_params) unless wizard_mode
    rescue => ex
      index_error(ex, wizard_mode)
    end
    form_completion_redirect(wizard_mode)
  end

  def create
    process_form(DutyStatus.new(), params[controller_path])
  end

  def update
    process_form(DutyStatus.find(params[controller_path][:id]), params[controller_path])
  end

end
