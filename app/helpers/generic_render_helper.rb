module GenericRenderHelper

  def payment_scheme_date(date_aspect, selected_employee, date_of_attendance, current_attendance_date_time)
    render(:partial => 'human_resources/compensation_and_benefits/payrolls/payment_scheme_date', :locals => {:link => link, :id => id})
  end
  
  def generic_payroll_add_link(link,id)
    render(:partial => 'core_partials/generic_payroll_add_link', :locals => {:link => link, :id => id})
  end

  def generic_payroll_examine_link(link,id)
    render(:partial => 'core_partials/generic_payroll_examine_link', :locals => {:link => link, :id => id})
  end

  def generic_employee_profile_link(model_with_employee_association)
    render(:partial => 'core_partials/generic_employee_profile_link', :locals => {:model_with_employee_association => model_with_employee_association})
  end

  def generic_table_error(ex)
    render(:partial => 'core_partials/generic_table_error', :locals => {:ex => ex})
  end

  def generic_remarks_description_field(model_name, default_remark)
    render(:partial => 'core_partials/generic_remark_description_field', :locals => {:model_name => model_name, :default_remark => default_remark})
  end

  def generic_employee_select_field(model_name, model_employee_id)
    render(:partial => 'core_partials/generic_employee_select_field', :locals => {:model_name => model_name,:model_employee_id => model_employee_id})
  end

  def generic_form_method_switch(selected_model)
    render(:partial => 'core_partials/generic_form_method_switch', :locals => {:selected_model => selected_model})
  end

  def generic_title(title, caption)
    render(:partial => 'core_partials/generic_title', :locals => {:title => title, :caption => caption})
  end

  def generic_actor_profile_link(my_ID, my_name)
    render(:partial => 'core_partials/generic_actor_profile_link', :locals => {:my_ID => my_ID, :my_name => my_name})
  end

  def generic_form_edit_id_indicator(selected_model_id)
    render(:partial => 'core_partials/generic_form_edit_id_indicator', :locals => {:selected_model_id => selected_model_id})
  end

  def generic_form_footer(selected_model_id)
    render(:partial => 'core_partials/generic_form_footer', :locals => {:selected_model_id => selected_model_id})
  end

  def generic_table_actions(model_id)
    render(:partial => 'core_partials/generic_table_actions', :locals => { :model_id => model_id})
  end

  def generic_table_theadlink(head_title, order_parameter, table_orientation)
    render(:partial => 'core_partials/generic_table_theadlink', :locals => {:head_title => head_title, :order_parameter => order_parameter, :table_orientation => table_orientation})
  end

  def generic_table_footer(result_set)
    render(:partial => 'core_partials/generic_table_footer', :locals => {:result_set => result_set})
  end

  def generic_table_search()
    render(:partial => 'core_partials/generic_table_search')
  end

  def generic_actor_search()
    render(:partial => 'core_partials/generic_actor_search')
  end

  def generic_search_footer(result_set)
    render(:partial => 'core_partials/generic_search_pagination', :locals => {:result_set => result_set})
  end

  def preheader_generic_table(title,subtitle)
    render(:partial => 'core_partials/preheader_generic_table', :locals => {:title => title,:subtitle => subtitle})
  end

end