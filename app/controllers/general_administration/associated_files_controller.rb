class GeneralAdministration::AssociatedFilesController  < GeneralAdministrationController

  def index
    main_model = FileSet, ImageSet, LinkSet
    @associated_files = multiple_model_search(main_model)
  end

  def search_suggestions
  end

  def new
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
