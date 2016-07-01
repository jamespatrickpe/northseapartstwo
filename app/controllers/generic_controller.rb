module GenericController

  def html5datetimelocal_to_rubydatetime(raw_params)
    DateTime.parse(raw_params)
  end

  def get_contactable_entities
    digital_contactables = Digital.all_polymorphic_types(:digitable).map(&:to_s)
    address_contactables = Address.all_polymorphic_types(:addressable).map(&:to_s)
    telephone_contactables = Telephone.all_polymorphic_types(:telephonable).map(&:to_s)
    contactables = digital_contactables | address_contactables | telephone_contactables
  end

  def generic_employee_name_search_suggestions(model)
    my_model = model.includes(employee: :system_accounts).where("actors.name LIKE (?)", "%#{ params[:query] }%").pluck("actors.name")
    direct = "{\"query\": \"Unit\",\"suggestions\":" + my_model.uniq.to_s + "}" # default format for plugin
    respond_to do |format|
      format.all { render :text => direct}
    end
  end

  def initialize_employee_selection
    @employees = Employee.includes(:system_account).joins(:system_accounts)
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

  def form_completion_redirect(wizard_mode)
    unless wizard_mode
      if params[:add_another] != nil
        redirect_to :action => 'new'
      else
        redirect_to :action => 'index'
      end
    end
  end

  def index_error(ex, wizard_mode)
      flash[:general_flash_notification] = "Error has Occured: " + ex.to_s unless wizard_mode
      puts ex.to_s
      puts ex.backtrace.to_s
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

  def set_process_notification(current_params = nil)
    flash[:general_flash_notification_type] = 'affirmative'
    if action_name == 'update'
      my_ID = params[controller_path][:id]
      flash[:general_flash_notification] = 'Updated' + ' ' + controller_name.gsub('_',' ').capitalize + ' ' + my_ID
    elsif
      flash[:general_flash_notification] = 'Created New' + ' ' + controller_name.gsub('_',' ').capitalize
    else
      flash[:general_flash_notification] = 'Performed ' + action_name + ' ' + controller_name.gsub('_',' ').capitalize
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
    name = class_model.find( my_ID ).main_representation[[:attribute]]
    class_model.find( my_ID ).delete
    flash[:general_flash_notification_type] = 'negative'
    flash[:general_flash_notification] = 'Deleted ' + name.to_s
    redirect_to :action => "index"
  end

  def setup_step(subtitle,selected_model_instance, submit_and_add_another = true)
    @subtitle = subtitle
    @selected_model_instance = selected_model_instance.new()
    @submit_and_add_another = submit_and_add_another
  end

  def process_parameter(form_parameter, attribute, wizard_parameter)
    returned_parameter = ''
    if wizard_parameter == nil
      returned_parameter = form_parameter[attribute.to_sym]
    else
      returned_parameter = wizard_parameter[attribute.to_sym]
    end
    returned_parameter
  end

  def setup_update_wizard_step(main_model)
    main_model_instance = main_model.new
    controller_instance = main_model_instance.main_representation[:controller_class].new
    controller_instance.process_form(main_model_instance, params[controller_path], true)
    main_model_instance.id
  end

  def redirect_setup_update(params, wizard_primary_model_type, extracted_id = nil)

    wizard_primary_model_id = (extracted_id ||= params[:wizard_primary_model_id])

    (params[:add_another] != nil) ? base_path = wizard_path : base_path = next_wizard_path
    redirection_path = base_path + "?wizard_primary_model_id=" + wizard_primary_model_id + "&wizard_primary_model_type=" + wizard_primary_model_type
    redirect_to redirection_path
  end

end