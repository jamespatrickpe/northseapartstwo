module GenericFormHelper

  def generic_form_edit_id_indicator(selected_model_id)
    render(:partial => 'common_partials/generic_form/generic_form_edit_id_indicator', :locals => {:selected_model_id => selected_model_id})
  end

  def generic_form_footer(selected_model_id)
    render(:partial => 'common_partials/generic_form/generic_form_footer', :locals => {:selected_model_id => selected_model_id})
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
    render( :partial => controller_path + "/summary",
            :locals => {:parent_model => parent_model,
                        :parent_id => parent_id }
    )
  end

  def generic_horizontal_title(title)
    render(
        :partial => 'common_partials/horizontal_rule_title',
        :locals => {:title => title}
    )

  end

end