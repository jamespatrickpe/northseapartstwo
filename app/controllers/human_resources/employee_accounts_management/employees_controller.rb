class HumanResources::EmployeeAccountsManagement::EmployeesController < HumanResources::EmployeeAccountsManagementController

  def index
    query = generic_table_aggregated_queries('employees','employees.created_at')
    begin
      @employees = Employee.includes(:actor, :duty_status, :branch)
                           .joins(:actors, :duty_status, :branch)
                           .where("employees.id LIKE ? OR " +
                                  "duty_statuses.active LIKE ? OR " +
                                  "branches.name LIKE ? OR " +
                                  "actors.name LIKE ? ",
                                  "%#{query[:search_field]}%",
                                  "%#{query[:search_field]}%",
                                  "%#{query[:search_field]}%",
                                  "%#{query[:search_field]}%",)
                           .order(query[:order_parameter] + ' ' + query[:order_orientation])
      @employees = Kaminari.paginate_array(@employees).page(params[:page]).per(query[:current_limit])
    rescue => ex
      flash[:general_flash_notification] = "Error has Occured" + ex.to_s
    end
    render 'human_resources/employee_accounts_management/employees/index'
  end

end
