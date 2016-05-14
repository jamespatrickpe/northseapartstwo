class GeneralAdministration::AssociatedFilesController  < GeneralAdministrationController

  def index
    main_model = FileSet, ImageSet, LinkSet, Association
    initialize_generic_index(main_model, 'Associated Files for any Entity')
  end

  def search_suggestions
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
