module GenericFormHelper

  def generic_form_money(f,attribute_name,selected_model_instance)
    render(:partial => 'common_partials/generic_form/money_field',
           :locals => {:f => f,
                       :attribute_name => attribute_name,
                       :selected_model_instance => selected_model_instance
           })
  end

  def generic_form_collection_selector(f,attribute_name, my_label,my_collection,selected_model_instance)
    render(:partial => 'common_partials/generic_form/collection_selector',
           :locals => {:f => f,
                       :attribute_name => attribute_name,
                       :my_label => my_label,
                       :my_collection => my_collection,
                       :selected_model_instance => selected_model_instance
           })
  end

  def generic_form_edit_id_indicator(selected_model_id)
    render(:partial => 'common_partials/generic_form/generic_form_edit_id_indicator', :locals => {:selected_model_id => selected_model_id})
  end

  def generic_form_footer(selected_model_id, f)
    render(:partial => 'common_partials/generic_form/generic_form_footer', :locals => {:selected_model_id => selected_model_id, :f => f})
  end

  def generic_remarks_remark_field(model_name, default_remark)
    render(:partial => 'common_partials/generic_remark_remark_field', :locals => {:model_name => model_name, :default_remark => default_remark})
  end

  def generic_form_method_switch(selected_model)
    render(:partial => 'common_partials/generic_form/generic_form_method_switch', :locals => {:selected_model => selected_model})
  end

  def generic_employee_select_field(model_name, model_employee_id)
    render(:partial => 'human_resources/generic_employee_select_field', :locals => {:model_name => model_name,:model_employee_id => model_employee_id})
  end

  def generic_form_remark_field(field_variable, selected_model)
    render(:partial => 'common_partials/generic_form/remark_field', :locals => {:field_variable => field_variable,:selected_model => selected_model})
  end

  def generic_form_horizontal_subdivision(subdivision_name, array_set = nil)
    render(:partial => 'common_partials/horizontal_subdivision', :locals => {:subdivision_name => subdivision_name, :array_set => array_set})
  end


  def polymorphic_selector(selected_model_instance = nil,polymorphic_attribute,f)
    render(:partial => 'common_partials/generic_form/polymorphic_selector',
           :locals => {:selected_model_instance => selected_model_instance,
                       :f => f,
                       :polymorphic_attribute => polymorphic_attribute})
  end

  def field_measurement(f, name, current_label, selected_model_instance, default_unit)
    render(:partial => 'common_partials/generic_form/field_measurement',
           :locals => {:f => f,
                       :name => name,
                       :current_label => current_label,
                       :selected_model_instance => selected_model_instance,
                       :default_unit => default_unit
           })
  end

  def related_summary(controller_path, parent_model, parent_id)
    @summary = true
    render( :partial => controller_path + "/summary",
            :locals => {:parent_model => parent_model,
                        :parent_id => parent_id})
  end

  def generic_horizontal_title(title)
    render(
        :partial => 'common_partials/horizontal_rule_title',
        :locals => {:title => title}
    )

  end

  def setup_wizard_step
    render :template => 'common_partials/generic_form/_main',
           :locals => {:selected_model_instance => @selected_model_instance }
  end

  def wizard_activated?
    if (defined?(wizard_path)).nil?
      control = false
    else
      control = true
    end
    control
  end

  def generally_new?
    ( wizard_activated? == true || action_name == 'new' )
  end

  def wizard_final_step(home_controller)
    render :template => 'common_partials/generic_wizard/final_step',
           :locals => {:home_controller => home_controller }
  end

  def related_models(primary_model_type = nil, primary_model_id = nil)
    render :partial => 'common_partials/generic_form/related_models',
           :locals => {:primary_model_type => primary_model_type, :primary_model_id => primary_model_id}
  end

end