module GenericTableHelper

  def generic_table_actions(current_model_instance)
    render(:partial => 'common_partials/generic_table/actions', :locals => { :current_model_instance => current_model_instance})
  end

  def generic_table_theadlink(head_title, order_parameter = head_title.downcase.tr(" ", "_") )
    render(:partial => 'common_partials/generic_table/theadlink', :locals => {:head_title => head_title,
                                                                              :order_parameter => order_parameter})
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

  def preheader_generic_table( subtitle,title = controller_name.gsub('_',' ') )
    render(:partial => 'common_partials/generic_table/preheader', :locals => {:title => title,:subtitle => subtitle})
  end

  def generic_search_footer(result_set)
    render(:partial => 'common_partials/generic_table/pagination', :locals => {:result_set => result_set})
  end

  def generic_actor_profile_link(my_ID, my_name)
    render(:partial => 'common_partials/generic_table/profile_link', :locals => {:my_ID => my_ID, :my_name => my_name})
  end

  def no_records_found
    render(:partial => 'common_partials/generic_table/no_records_found')
  end

  def generate_theadlinks(*theadlink_set)
    render(:partial => 'common_partials/generic_table/theadlink_set', :locals => {:theadlink_set => theadlink_set})
  end

  def polymorphic_link(model_type, model_id)
    render(:partial => 'common_partials/generic_table/polymorphic_link', :locals => {:model_type => model_type, :model_id => model_id})
  end

  def generic_table_datetime(active_support_time_with_zone)
    render(:partial => 'common_partials/generic_table/datetime', :locals => {:active_support_time_with_zone => active_support_time_with_zone})
  end

  def generic_table_remark(remark_string)
    render(:partial => 'common_partials/generic_table/remark', :locals => {:remark_string => remark_string})
  end

  def generic_table_id(current_model_instance)
    render(:partial => 'common_partials/generic_table/table_id', :locals => {:current_model_instance => current_model_instance})
  end

  def generic_table_last_rows(current_model_instance, controller_link = '')
    render(:partial => 'common_partials/generic_table/last_rows', :locals => {:current_model_instance => current_model_instance, :controller_link => controller_link})
  end

  def generic_table_theadlink_last_head(head_title_one = "Created at", head_title_two = "Updated at", order_parameter_one = head_title_one.downcase.tr(" ", "_"), order_parameter_two = head_title_two.downcase.tr(" ", "_") )
    render(:partial => 'common_partials/generic_table/last_head', :locals => {:head_title_one => head_title_one,
                                                                              :head_title_two => head_title_two,
                                                                              :order_parameter_one => order_parameter_one,
                                                                              :order_parameter_two => order_parameter_two})
  end

end