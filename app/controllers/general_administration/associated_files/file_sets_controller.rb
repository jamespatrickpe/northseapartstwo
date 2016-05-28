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

  def process_form(my_file, current_params, wizard_mode = nil)
    begin
      my_file[:remark] =current_params[:remark]
      my_file.remove_file if action_name == 'edit'
      my_file.file = current_params[:file]
      my_file[:physical_storage] = current_params[:physical_storage]
      my_file[:filesetable_type] = current_params[:filesetable_type]
      my_file[:filesetable_id] = current_params[:filesetable_id]
      my_file.save!
      set_process_notification unless wizard_mode
    rescue => ex
      index_error(ex, wizard_mode)
    end
    form_completion_redirect(wizard_mode)
  end

  def create
    process_form(FileSet.new(), params[controller_path])
  end

  def update
    process_form(FileSet.find(params[controller_path][:id]), params[controller_path])
  end

end