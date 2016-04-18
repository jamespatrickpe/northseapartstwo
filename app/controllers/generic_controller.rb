module GenericController

  def generic_employee_name_search_suggestions(model)
    my_model = model.includes(employee: :actors).where("actors.name LIKE (?)", "%#{ params[:query] }%").pluck("actors.name")
    direct = "{\"query\": \"Unit\",\"suggestions\":" + my_model.uniq.to_s + "}" # default format for plugin
    respond_to do |format|
      format.all { render :text => direct}
    end
  end

  def initialize_employee_selection
    @employees = Employee.includes(:actor).joins(:actors)
  end

  #Reset Search Common Paremeters
  def reset_search
    flash.clear
    flash[:general_flash_notification] = 'Search Queries Cleared'
    flash[:general_flash_notification_type] = 'affirmative'
    redirect_to params[:reset_search_redirect]
  end

  def getEmployees
    @employees = Employee.all
    @employee_id = params[:employee_id]
  end

end