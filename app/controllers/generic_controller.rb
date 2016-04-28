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

  def render_index
    render controller_path + '/index'
  end

  def redirect_to_index
    redirect_to :action => 'index'
  end

  def index_error(ex)
    puts ex.to_s
    flash[:general_flash_notification] = ""
    flash[:general_flash_notification] = "Error has Occured: " + ex.to_s
  end

  def get_model_id
    begin
      main_model = params[:query].constantize
      main_query = main_model.all
      respond_to do |format|
        format.all { render :json => main_query}
      end
    rescue => ex
      head :ok, content_type: "text/html"
    end
  end

  def set_process_notification
    flash[:general_flash_notification_type] = 'affirmative'
    if action_name == 'update'
      my_ID = params[controller_path][:id]
      flash[:general_flash_notification] = 'Updated' + ' ' + controller_name + ' | ' + my_ID
    elsif
      flash[:general_flash_notification] = 'Created New' + ' ' + controller_name
    else
      flash[:general_flash_notification] = 'Performed ' + action_name + ' ' + controller_name
    end
  end

  def set_new_edit(class_model)
    initialize_form
    if params[:id]
      selected_model_instance = class_model.find(params[:id])
    else
      selected_model_instance = class_model.new
    end
    generic_form_main(selected_model_instance)
  end

  def get_params(attribute)
    params[controller_path][attribute.to_sym]
  end

end