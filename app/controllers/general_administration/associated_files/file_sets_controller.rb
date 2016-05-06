class GeneralAdministration::AssociatedFiles::FileSetsController < GeneralAdministration::AssociatedFilesController

  def index
    @file_sets = initialize_generic_table(FileSet)
  end

  def search_suggestions
    simple_singular_column_search('file_sets.remark',FileSet)
  end

  def new
    set_new_edit(FileSet)
  end

  def edit
    set_new_edit(FileSet)
  end

  def show
    edit
  end

  def delete
    generic_delete(FileSet)
  end

  def process_file_form(myFile)
    begin
      myFile[:remark] = params[controller_path][:remark]
      myFile.file = params[controller_path][:file]
      myFile[:filesetable_type] = params[controller_path][:filesetable_type]
      myFile[:filesetable_id] = params[controller_path][:filesetable_id]
      myFile.save!
      set_process_notification
    rescue => ex
      index_error(ex)
    end
    redirect_to_index
  end

  def create
    process_file_form(FileSet.new())
  end

  def update
    process_file_form(FileSet.find(params[controller_path][:id]))
  end

end