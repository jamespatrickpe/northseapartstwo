module GenericForm

  def generic_tricolumn_form_with_employee_selection(model)
    render :template => 'human_resources/_tricolumn_with_employee_selection', :locals => {:model => model}
  end

  def generic_bicolumn_form_with_employee_selection(model)
    render :template => 'human_resources/_bicolumn_with_employee_selection', :locals => {:model => model}
  end

  def generic_single_column_form(model)
    render :template => 'common_partials/generic_form/_single_column', :locals => {:model => model}
  end

  def generic_delete_model(model, my_controller_name)
    model_to_be_deleted = model.find(params[:id])
    flash[:general_flash_notification] = model_to_be_deleted.id + " has been successfully deleted "
    flash[:general_flash_notification_type] = 'affirmative'
    model_to_be_deleted.destroy
    redirect_to :controller => my_controller_name, :action => 'index'
  end

  def initialize_form_variables(title, form_location, singular_model_name)
    @title = title
    @subtitle = action_name + " " + title
    @form_location = form_location
    @singular_model_name = singular_model_name
  end

end