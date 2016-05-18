module GenericIndexHelper

  def check_partial_exists(current_path)
    lookup_context.find_all( current_path ).any?
  end

  def controller_link(current_model_instance)
    ((current_model_instance.main_representation)[:controller_path])
  end

  def generic_index_actions(current_model_instance, controller_link = nil)
    render partial: 'common_partials/generic_index/actions', locals: {
                                                               current_model_instance: current_model_instance,
                                                               controller_link: controller_link }
  end

  def generic_index_theadlink(head_title, order_parameter = head_title.downcase.tr(" ", "_"), arrow = true )
    render(:partial => 'common_partials/generic_index/theadlink', :locals => {:head_title => head_title,
                                                                              :order_parameter => order_parameter,
                                                                              :arrow => arrow})
  end

  def generic_index_footer(result_set)
    render(:partial => 'common_partials/generic_index/footer', :locals => {:result_set => result_set})
  end

  def generic_index_error(ex)
    render(:partial => 'common_partials/generic_index/error', :locals => {:ex => ex})
  end

  def preheader_generic_index()
    render(:partial => 'common_partials/generic_index/preheader')
  end

  def generic_search_footer(result_set)
    render(:partial => 'common_partials/generic_index/pagination', :locals => {:result_set => result_set})
  end

  def generic_actor_profile_link(my_ID, my_name)
    render(:partial => 'common_partials/generic_index/profile_link', :locals => {:my_ID => my_ID, :my_name => my_name})
  end

  def no_records_found
    render(:partial => 'common_partials/generic_index/no_records_found')
  end

  def generate_theadlinks(*theadlink_set)
    render(:partial => 'common_partials/generic_index/theadlink_set', :locals => {:theadlink_set => theadlink_set})
  end

  def polymorphic_link(current_instance_type, current_instance_id)
    render(:partial => 'common_partials/generic_index/polymorphic_link',
           :locals => {:current_instance_type => current_instance_type,
                       :current_instance_id => current_instance_id
           })
  end

  def generic_index_datetime(active_support_time_with_zone)
    render(:partial => 'common_partials/generic_index/datetime', :locals => {:active_support_time_with_zone => active_support_time_with_zone})
  end

  def generic_index_remark(remark_string)
    render(:partial => 'common_partials/generic_index/remark', :locals => {:remark_string => remark_string})
  end

  def generic_index_id(current_model_instance)
    render(:partial => 'common_partials/generic_index/table_id', :locals => {:current_model_instance => current_model_instance})
  end

  def generic_index_last_rows(current_model_instance, controller_link = '')
    render(:partial => 'common_partials/generic_index/last_rows', :locals => {:current_model_instance => current_model_instance, :controller_link => controller_link})
  end

  def generic_index_theadlink_last_head(head_title_one = "Created at", head_title_two = "Updated at", order_parameter_one = head_title_one.downcase.tr(" ", "_"), order_parameter_two = head_title_two.downcase.tr(" ", "_") )
    render(:partial => 'common_partials/generic_index/last_head', :locals => {:head_title_one => head_title_one,
                                                                              :head_title_two => head_title_two,
                                                                              :order_parameter_one => order_parameter_one,
                                                                              :order_parameter_two => order_parameter_two})
  end

  def generic_display_selector()
    render(:partial => 'common_partials/generic_index/display_selector')
  end

end