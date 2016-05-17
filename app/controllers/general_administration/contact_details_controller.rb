class GeneralAdministration::ContactDetailsController < GeneralAdministrationController

  def index
    main_models = [Digital, Telephone, Address]
    @overview_panels = [
        [general_administration_contact_details_addresses_path,'Addresses'],
        [general_administration_contact_details_digitals_path,'Digitals'],
        [general_administration_contact_details_telephones_path,'Telephones']
    ]
    initialize_generic_index(main_models, 'Contact Details for any Entity')
  end

  def search_suggestions
    main_models = [Digital, Telephone, Address]
    generic_index_search_suggestions(main_models)
  end

  def new
    render :template => general_administration_contact_details_path + '/_form'
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