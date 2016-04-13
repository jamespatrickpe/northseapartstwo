module GenericTableHelper

  def generic_table_actions(model_id)
    render(:partial => 'common_partials/generic_table_actions', :locals => { :model_id => model_id})
  end

  def generic_table_theadlink(head_title, order_parameter)
    render(:partial => 'common_partials/generic_table_theadlink', :locals => {:head_title => head_title, :order_parameter => order_parameter})
  end

  def generic_table_footer(result_set)
    render(:partial => 'common_partials/generic_table_footer', :locals => {:result_set => result_set})
  end

  def generic_table_search()
    render(:partial => 'common_partials/generic_table_search')
  end

  def generic_search_footer(result_set)
    render(:partial => 'common_partials/generic_search_pagination', :locals => {:result_set => result_set})
  end

  def generic_table_error(ex)
    render(:partial => 'common_partials/generic_table_error', :locals => {:ex => ex})
  end

  def preheader_generic_table(title,subtitle)
    render(:partial => 'common_partials/preheader_generic_table', :locals => {:title => title,:subtitle => subtitle})
  end

  def generic_employee_profile_link(model_with_employee_association)
    render(:partial => 'common_partials/generic_employee_profile_link', :locals => {:model_with_employee_association => model_with_employee_association})
  end

  def generic_actor_profile_link(my_ID, my_name)
    render(:partial => 'common_partials/generic_actor_profile_link', :locals => {:my_ID => my_ID, :my_name => my_name})
  end

end