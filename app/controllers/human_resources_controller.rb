class HumanResourcesController < ApplicationController

  layout "application_loggedin"

  def index

    @overview_panels = [
        [human_resources_employee_accounts_management_path,'Employee Accounts Management'],
        [human_resources_attendance_performance_path,'Attendance'],
        [human_resources_compensation_and_benefits_path,'Compensation and Benefits'],
        [human_resources_settings_path,'Settings']
    ]

    generic_index_main('Management of Human Assets in the Enterprise')

  end

  def employee_overview_profile
    respond_to do |format|
      employee_overview_profile = Employee.find(params[:employee_ID]).to_json({ :include => :system_accounts })
      format.all { render :json => employee_overview_profile}
    end
  end

  def employee_overview_duty_status
    currentEmployee = Employee.includes(:duty_status).joins(:duty_status).where("(employees.id = ?)", "#{params[:employee_ID]}").order('duty_statuses.date_of_implementation DESC').first
    if currentEmployee.duty_status.first.active == true
      sample = 'ACTIVE'
    else
      sample = 'INACTIVE'
    end
    respond_to do |format|
      format.all { render :text => sample}
    end
  end

  def check_employee_name_exists
    employee_name = params[:employee_select_field]
    result = Employee.includes(:system_account).joins(:system_accounts).where("actors.name = ?","#{employee_name}").exists?
    respond_to do |format|
      format.json { render json: {:"exists" => result}.to_json }
      format.html
    end
  end

end