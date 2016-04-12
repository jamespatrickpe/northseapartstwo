class HumanResources::EmployeeAccountsManagement::EmployeesController < HumanResources::EmployeeAccountsManagementController

  def index
    query = generic_table_aggregated_queries('employees','employees.created_at')
    # actor.name, current branch, current duty status
    begin
      @employees = Employee.includes(:actor, :duty_status, :branch)
                           .joins(:actor, :duty_status, :branch)
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
    #   sql = "SELECT employees.id as id, actors.name as name, dutystatus.active as active, branches.name as branch_name, employees.created_at as created_at, employees.updated_at as updated_at, actors.id  as actors_id
    # FROM employees
    # INNER JOIN actors ON employees.actor_id = actors.id
    # INNER JOIN branches ON employees.branch_id = branches.id
    # INNER JOIN ( SELECT employee_id, active, max(duty_statuses.created_at) FROM duty_statuses GROUP BY employee_id )
    # AS dutystatus ON dutystatus.employee_id = employees.id WHERE" +
    #       "(employees.id LIKE '%" + search_field + "%' " + ")" + " OR " +
    #       "(actors.name LIKE '%" + search_field + "%' " + ")" + " OR " +
    #       "(dutystatus.active LIKE '%" + search_field + "%' " + ")" + " OR " +
    #       "(branches.name LIKE '%" + search_field + "%' " + ")" + " OR " +
    #       "(employees.created_at LIKE '%" + search_field + "%' " + ")" + " OR " +
    #       "(employees.updated_at LIKE '%" + search_field + "%' " + ")" + " " +
    #       "ORDER BY " + order_parameter + " " + order_orientation;
    #   @employee_accounts = ActiveRecord::Base.connection.execute(sql)
    #   @employee_accounts = Kaminari.paginate_array(@employee_accounts.each( :as => :array )).page(params[:page]).per(current_limit)
    rescue => ex
      flash[:general_flash_notification] = "Error has Occured" + ex.to_s
    end
    render 'human_resources/employee_accounts_management/employees/index'
  end

=begin
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
=end

end
