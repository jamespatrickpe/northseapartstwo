module GenericTable

  # Shifts the ASC/DESC on the header of table
  def shift_table_orientation
    table_orientation = Hash.new()
    table_orientation["order_orientation"] = ""
    table_orientation["orientation_symbol"] = ""
    if( params[:order_orientation] == "ASC" )
      table_orientation["order_orientation"] = "DESC"
      table_orientation["orientation_symbol"] = '&#x25BC;'
    else
      table_orientation["order_orientation"] = "ASC"
      table_orientation["orientation_symbol"] = '&#x25B2;'
    end
    return table_orientation
  end

  def generic_table_aggregated_queries( mysql_table_name, mysql_created_at, my_order = 'DESC', my_limit = '10')
    order_parameter = aggregated_search_queries(params[:order_parameter], mysql_table_name, 'order_parameter' , mysql_created_at)
    order_orientation = aggregated_search_queries(params[:order_orientation], mysql_table_name, 'order_orientation', my_order)
    current_limit = aggregated_search_queries(params[:current_limit], mysql_table_name, 'current_limit', my_limit)
    search_field = aggregated_search_queries(params[:search_field], mysql_table_name, 'search_field','')
    return {:order_parameter => order_parameter, :order_orientation => order_orientation, :current_limit => current_limit, :search_field => search_field}
  end

  # Stores previous search queries for aggregated results
  def aggregated_search_queries(value, table_id, key, default)
    if value
      actual_query_parameter = value
    elsif flash[table_id + '_' + key]
      actual_query_parameter = flash[table_id + '_' + key]
    else
      actual_query_parameter = default
    end
    flash[table_id + '_' + key] = actual_query_parameter
    return actual_query_parameter
  end


end