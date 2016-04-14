module GenericTableHelper

  def generic_table_actions(model_id)
    render(:partial => 'common_partials/generic_table/actions', :locals => { :model_id => model_id})
  end

  def generic_table_theadlink(head_title, order_parameter)
    render(:partial => 'common_partials/generic_table/theadlink', :locals => {:head_title => head_title, :order_parameter => order_parameter})
  end

  def generic_table_footer(result_set)
    render(:partial => 'common_partials/generic_table/footer', :locals => {:result_set => result_set})
  end

  def generic_table_search()
    render(:partial => 'common_partials/generic_table/search')
  end

  def generic_table_error(ex)
    render(:partial => 'common_partials/generic_table/error', :locals => {:ex => ex})
  end

  def preheader_generic_table(title,subtitle)
    render(:partial => 'common_partials/preheader_generic_table', :locals => {:title => title,:subtitle => subtitle})
  end

  def generic_search_footer(result_set)
    render(:partial => 'common_partials/generic_table/pagination', :locals => {:result_set => result_set})
  end

  def generic_actor_profile_link(my_ID, my_name)
    render(:partial => 'common_partials/generic_table/profile_link', :locals => {:my_ID => my_ID, :my_name => my_name})
  end

end