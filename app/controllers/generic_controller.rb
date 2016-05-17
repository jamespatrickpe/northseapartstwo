module GenericController

  def get_contactable_entities
    digital_contactables = Digital.all_polymorphic_types(:digitable).map(&:to_s)
    address_contactables = Address.all_polymorphic_types(:addressable).map(&:to_s)
    telephone_contactables = Telephone.all_polymorphic_types(:telephonable).map(&:to_s)
    contactables = digital_contactables | address_contactables | telephone_contactables
  end

  def generic_employee_name_search_suggestions(model)
    my_model = model.includes(employee: :system_actors).where("actors.name LIKE (?)", "%#{ params[:query] }%").pluck("actors.name")
    direct = "{\"query\": \"Unit\",\"suggestions\":" + my_model.uniq.to_s + "}" # default format for plugin
    respond_to do |format|
      format.all { render :text => direct}
    end
  end

  def initialize_employee_selection
    @employees = Employee.includes(:system_actor).joins(:system_actors)
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
      flash[:general_flash_notification] = 'Updated' + ' ' + controller_name.gsub('_',' ') + ' | ' + my_ID
    elsif
      flash[:general_flash_notification] = 'Created New' + ' ' + controller_name.gsub('_',' ')
    else
      flash[:general_flash_notification] = 'Performed ' + action_name + ' ' + controller_name.gsub('_',' ')
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

  def generic_delete(class_model)
    my_ID = params[:id]
    class_model.find( my_ID ).destroy
    flash[:general_flash_notification_type] = 'negative'
    flash[:general_flash_notification] = 'Deleted' + ' ' + controller_name + ' | ' + my_ID
    redirect_to :action => "index"
  end

end