module GenericIndex

  # Initializes the Common Functions in a Single Model - Controller Logic Unit
  def initialize_generic_index(main_model, subtitle,includes = '')
    begin
      query = generic_index_aggregated_queries(controller_name,'updated_at')
      @result_set = search_index(main_model, query, includes)
    rescue => ex
      index_error(ex)
    end
    @result_set
    generic_index_main(subtitle)
  end

  # Get the proper set of queries according to defaults and priority
  def generic_index_aggregated_queries( controller_name, default_order_paremeter, my_order = 'DESC', my_limit = '10')
    order_parameter = aggregated_search_queries(params[:order_parameter], controller_name, 'order_parameter' , default_order_paremeter)
    order_orientation = aggregated_search_queries(params[:order_orientation], controller_name, 'order_orientation', my_order)
    current_limit = aggregated_search_queries(params[:current_limit], controller_name, 'current_limit', my_limit)
    search_field = aggregated_search_queries(params[:search_field], controller_name, 'search_field','')
    view_mode = aggregated_search_queries(params[:view_mode], controller_name, 'view_mode', 'table')
    return {:order_parameter => order_parameter,
            :order_orientation => order_orientation,
            :current_limit => current_limit,
            :search_field => search_field,
            :view_mode => view_mode}
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

  # Perform Solr Sunspot Search on Model
  def search_index(main_model, query, includes = '')
    search = Sunspot.search( main_model ) do
      fulltext query[:search_field]
      keywords query[:search_field]
      order_by query[:order_parameter].to_sym,
               query[:order_orientation].parameterize.underscore.to_sym
      paginate :page => params[:page],
               :per_page => query[:current_limit]
    end
    search.results
  end

  # Renders the Main Index
  def generic_index_main(subtitle)
    render :template => 'common_partials/generic_index/_main', :locals => {:subtitle => subtitle}
  end

  def extract_polymorphic_attribute(main_model)

    type_key = nil
    id_key = nil
    polymorphic_attribute = nil

    key_array = main_model.column_names
    key_array.each do |key|
      if key.to_s.include? "_type"
        type_key = key.to_s.gsub("_type",'')
      end
      if key.to_s.include? "_id"
        id_key = key.to_s.gsub("_id",'')
      end
    end

    if (type_key == id_key) && (type_key != nil) && (id_key != nil)
      polymorphic_attribute = type_key
    end
    polymorphic_attribute

  end

  def get_polymorphic_values_on_array(query_array, main_model)

    polymorphic_attribute = extract_polymorphic_attribute(main_model)
    if polymorphic_attribute != nil
      association_models = main_model.all_polymorphic_types(polymorphic_attribute.to_sym)
      association_models.each do |current_model|

        associated_query = Sunspot.search ( current_model ) do
          fulltext params[:query]
          keywords params[:query]
        end

        associated_query.results.each do |result|
          query_array.push( (result.main_representation)[:attribute] )
        end

      end
    end
    query_array

  end

  # Gives a search suggestion for a single column - temporary only - must find better way to do this
  def generic_index_search_suggestions(main_model)

    # do the main query
    main_query = Sunspot.search (main_model) do
      fulltext params[:query]
      keywords params[:query]
    end

    # initialize iteration variables
    query_array = Array.new
    associated_array = Array.new
    polymorphic_attribute = nil

    # extract results
    main_query.results.each do |result|
      key_array = result.attributes.keys
      key_array.each do |key|
        value_in_field = result[key.to_sym].to_s.downcase
        if value_in_field.include? params[:query].to_s.downcase
          query_array.push( result[key.to_sym].to_s )
        end
      end
    end

    # if there is a polymorphic attribute, get the models
    if main_model.kind_of?(Array)
      main_model.each do |model|
        query_array = get_polymorphic_values_on_array(query_array, model)
      end
    else
      query_array =get_polymorphic_values_on_array(query_array, main_model)
    end


    # prepare AJAX transmission
    query_array.uniq!
    direct = "{\"query\": \"Unit\",\"suggestions\":[" + query_array.to_s.gsub!('[', '').gsub!(']', '') + "]}"
    respond_to do |format|
      format.all { render :text => direct}
    end

  end

end