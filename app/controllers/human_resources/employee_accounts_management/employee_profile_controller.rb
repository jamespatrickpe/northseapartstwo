class HumanResources::EmployeeAccountsManagement::EmployeeProfileController < HumanResources::EmployeeAccountsManagementController

  def index
    @selected_model = 'Employee'
    @actors = Actor.includes(:employee).joins(:employee)
    actor_profile
    @selected_employee = Employee.find_by_actor_id( params[:system_actor_id] )
    if @selected_employee.present?
      @selected_branch = Branch.find(@selected_employee.branch_id)
    end
    render 'shared/actor_profile'
  end

end
