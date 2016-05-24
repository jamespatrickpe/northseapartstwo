class GeneralAdministration::AssociatedFiles::FileSetsController < GeneralAdministration::AssociatedFilesController

  def index
    initialize_generic_index(FileSet, 'Related File Sets of different Entities')
  end

  def search_suggestions
    generic_index_search_suggestions(FileSet)
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
    FileSet.find(params[:id]).remove_file
    generic_delete(FileSet)
  end

  def process_form(myFile)
    begin
      myFile[:remark] = params[controller_path][:remark]
      if action_name == 'edit'
        myFile.remove_file
      end
      myFile.file = params[controller_path][:file]
      myFile[:physical_storage] = params[controller_path][:physical_storage]
      myFile[:filesetable_type] = params[controller_path][:filesetable_type]
      myFile[:filesetable_id] = params[controller_path][:filesetable_id]
      myFile.save!
      set_process_notification
    rescue => ex
      index_error(ex)
    end
    form_completion_redirect
  end

  def create
    process_form(FileSet.new())
  end

  def update
    process_form(FileSet.find(params[controller_path][:id]))
  end

end