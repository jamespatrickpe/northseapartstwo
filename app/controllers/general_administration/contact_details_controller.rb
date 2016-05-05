class GeneralAdministration::ContactDetailsController < GeneralAdministrationController

  def index
    main_model = Digital, Telephone, Address
    @contact_details = multiple_model_search(main_model)
  end

  def search_suggestions
    contactable_entities = get_contactable_entities
    main_query = []
    contactable_entities.each do |main_model|
      main_model = main_model.constantize
      current_query = main_model
                     .where('name' + " LIKE ?","%#{params[:query]}%")
                     .pluck('name')
    main_query += current_query
    end

    direct = "{\"query\": \"Unit\",\"suggestions\":[" + main_query.to_s.gsub!('[', '').gsub!(']', '') + "]}"

    respond_to do |format|
      format.all { render :text => direct}
    end
  end

  def new
    render :template => 'general_administration/contact_details/_form'
  end

  def edit
  end

  def show
  end

  def delete
  end

  def create
  end

  def update
  end

end