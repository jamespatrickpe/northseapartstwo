class GeneralAdministration::ContactDetailsController < GeneralAdministrationController

  def index

    main_model = Digital, Telephone, Address
    begin
      query = generic_table_aggregated_queries(controller_name,'created_at')
      search = Sunspot.search main_model do
        fulltext query[:search_field]
        order_by query[:order_parameter].to_sym,
                 query[:order_orientation].parameterize.underscore.to_sym
        paginate :page => params[:page],
                 :per_page => query[:current_limit]
      end
      result = search.results
    rescue => ex
      index_error(ex)
    end
    @contact_models = result

  end

  def search_suggestions
  end

end