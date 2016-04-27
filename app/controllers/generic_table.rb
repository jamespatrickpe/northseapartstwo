module GenericTable

  # Gives a search suggestion for a single column - temporary only - must find better way to do this
  def simple_singular_column_search(table_column,main_model)
    main_query = main_model
                     .where(table_column + " LIKE ?","%#{params[:query]}%")
                     .pluck(table_column)
    direct = "{\"query\": \"Unit\",\"suggestions\":[" + main_query.to_s.gsub!('[', '').gsub!(']', '') + "]}"
    respond_to do |format|
      format.all { render :text => direct}
    end
  end

  # Obtain set of Digital Model
  def initialize_generic_table(main_model, includes = '')
    begin
      query = generic_table_aggregated_queries(controller_name,'created_at')
      result = search_index(main_model, query, includes)
    rescue => ex
      index_error(ex)
    end
    result
  end

  # Perform Solr Sunspot Search on Model
  def search_index(main_model, query, includes = '')
    search = main_model.search(include: includes) do
      fulltext query[:search_field]
      order_by query[:order_parameter].to_sym,
               query[:order_orientation].parameterize.underscore.to_sym
      paginate :page => params[:page],
               :per_page => query[:current_limit]
    end
    search.results
  end

  # get query set
  def generic_table_aggregated_queries( controller_name, mysql_created_at, my_order = 'DESC', my_limit = '10')
    order_parameter = aggregated_search_queries(params[:order_parameter], controller_name, 'order_parameter' , mysql_created_at)
    order_orientation = aggregated_search_queries(params[:order_orientation], controller_name, 'order_orientation', my_order)
    current_limit = aggregated_search_queries(params[:current_limit], controller_name, 'current_limit', my_limit)
    search_field = aggregated_search_queries(params[:search_field], controller_name, 'search_field','')
    return {:order_parameter => order_parameter,
            :order_orientation => order_orientation,
            :current_limit => current_limit,
            :search_field => search_field}
  end

  # Stores previous search queries for aggregated results; priorities from which
  def aggregated_search_queries(value, controller_name, key, default)
    if value
      # if params has an actual value then use that
      actual_query_parameter = value
    elsif flash[controller_name + '_' + key]
      # if the flash parameter has an actual value then use that
      actual_query_parameter = flash[controller_name + '_' + key]
    else
      # if there is nothing else then use the provided default
      actual_query_parameter = default
    end
    flash[controller_name + '_' + key] = actual_query_parameter
    return actual_query_parameter
  end

  def generic_delete(class_model)
    my_ID = params[:id]
    class_model.find( my_ID ).destroy
    flash[:general_flash_notification_type] = 'negative'
    flash[:general_flash_notification] = 'Deleted' + ' ' + controller_name + ' | ' + my_ID
    redirect_to :action => "index"
  end

end