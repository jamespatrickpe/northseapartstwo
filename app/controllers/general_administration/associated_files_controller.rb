class GeneralAdministration::AssociatedFilesController  < GeneralAdministrationController

  def index
    main_models = [FileSet, ImageSet, LinkSet, SystemAssociation]
    @overview_panels = [
        [general_administration_associated_files_system_associations_path,'Association'],
        [general_administration_associated_files_file_sets_path,'File Sets'],
        [general_administration_associated_files_image_sets_path,'Image Sets'],
        [general_administration_associated_files_link_sets_path,'Link Sets']
    ]
    initialize_generic_index(main_models, 'Associated Files for any Entity')

  end

  def search_suggestions
    main_models = [FileSet, ImageSet, LinkSet, SystemAssociation]
    generic_index_search_suggestions(main_models)
  end

  def new
    render :template => general_administration_associated_files_path + '/_form'
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
