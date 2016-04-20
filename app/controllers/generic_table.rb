module GenericTable

  def initialize_search_suggestions(my_model)
    digitals = Digital
                   .where("digitals.url LIKE ?","%#{params[:query]}%")
                   .pluck("digitals.url")
    direct = "{\"query\": \"Unit\",\"suggestions\":[" + digitals.to_s.gsub!('[', '').gsub!(']', '') + "]}"
    respond_to do |format|
      format.all { render :text => direct}
    end
  end

  # Obtain set of Digital Model
  def initialize_generic_table(main_model)
    begin
      query = generic_table_aggregated_queries(controller_name,'created_at')
      result = search_index(main_model,query)
    rescue => ex
      index_error(ex)
    end
    result
  end

  # Perform Solr Sunspot Search on Model
  def search_index(main_model,query)
    @search = main_model.search do
      fulltext query[:search_field]
      order_by query[:order_parameter].to_sym,
               query[:order_orientation].parameterize.underscore.to_sym
      paginate :page => params[:page],
               :per_page => query[:current_limit]
    end
    @search.results
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


end