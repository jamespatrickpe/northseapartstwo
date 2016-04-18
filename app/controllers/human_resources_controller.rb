class HumanResourcesController < ApplicationController

  layout "application_loggedin"

  def index
    render 'human_resources/index'
  end

  def employee_overview_profile
    respond_to do |format|
      employee_overview_profile = Employee.find(params[:employee_ID]).to_json({ :include => :actors })
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
    result = Employee.includes(:actor).joins(:actors).where("actors.name = ?","#{employee_name}").exists?
    respond_to do |format|
      format.json { render json: {:"exists" => result}.to_json }
      format.html
    end
  end

end