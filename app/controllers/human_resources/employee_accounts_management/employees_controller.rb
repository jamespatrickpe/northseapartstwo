class HumanResources::EmployeeAccountsManagement::EmployeesController < HumanResources::EmployeeAccountsManagementController

  def index
    initialize_generic_index(Employee, 'Basic Human Resource Unit')
  end

  def search_suggestions
    generic_index_search_suggestions(Employee)
  end

  def new
    set_new_edit(Employee)
  end

  def edit
    set_new_edit(Employee)
  end

  def show
    edit
  end

  def delete
    generic_delete(Employee)
  end

  def process_form(my_employee, current_params, wizard_mode = nil)
    begin
      my_employee[:system_account_id] = current_params[:system_account_id]
      my_employee[:remark] = current_params[:remark]
      my_employee.save!
      set_process_notification(current_params) unless wizard_mode
    rescue => ex
      index_error(ex, wizard_mode)
    end
    form_completion_redirect(wizard_mode)
  end

  def create
    process_form(Employee.new(), params[controller_path])
  end

  def update
    process_form(Employee.find(params[controller_path][:id]), params[controller_path])
  end

end
