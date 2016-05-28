class GeneralAdministration::AssociatedFiles::ImageSetsController < GeneralAdministration::AssociatedFilesController

  def index
    initialize_generic_index(ImageSet, 'Related Image Sets of Different Entities')
  end

  def search_suggestions
    generic_index_search_suggestions(ImageSet)
  end

  def new
    set_new_edit(ImageSet)
  end

  def edit
    set_new_edit(ImageSet)
  end

  def show
    edit
  end

  def delete
    ImageSet.find(params[:id]).remove_picture
    generic_delete(ImageSet)
  end

  def process_form(my_image, current_params, wizard_mode = nil)
    begin
      my_image[:remark] = current_params[:remark]
      my_image.remove_picture if action_name == 'edit'
      my_image.picture = current_params[:picture]
      my_image[:priority] = current_params[:priority]
      my_image[:imagesetable_type] = current_params[:imagesetable_type]
      my_image[:imagesetable_id] = current_params[:imagesetable_id]
      my_image.save!
      set_process_notification unless wizard_mode
    rescue => ex
      index_error(ex, wizard_mode)
    end
    form_completion_redirect(wizard_mode)
  end

  def create
    process_form(ImageSet.new(), params[controller_path])
  end

  def update
    process_form(ImageSet.find(params[controller_path][:id]), params[controller_path])
  end

end