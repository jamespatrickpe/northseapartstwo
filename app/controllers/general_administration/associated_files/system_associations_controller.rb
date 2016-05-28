class GeneralAdministration::AssociatedFiles::SystemAssociationsController < GeneralAdministration::AssociatedFilesController

  def index
    initialize_generic_index(SystemAssociation, 'Model Relations')
  end

  def search_suggestions
    generic_index_search_suggestions(SystemAssociation)
  end

  def new
    set_new_edit(SystemAssociation)
  end

  def edit
    set_new_edit(SystemAssociation)
  end

  def show
    edit
  end

  def delete
    generic_delete(SystemAssociation)
  end

  def process_form(my_association, current_params, wizard_mode = nil)
    begin
      my_association[:remark] = current_params[:remark]
      my_association[:model_one_type] = current_params[:model_one_type]
      my_association[:model_one_id] = current_params[:model_one_id]
      my_association[:model_two_type] = current_params[:model_two_type]
      my_association[:model_two_id] = current_params[:model_two_id]
      my_association.save!
      set_process_notification(current_params)
    rescue => ex
      index_error(ex,wizard_mode)
    end
    form_completion_redirect(wizard_mode)
  end

  def create
    process_form(SystemAssociation.new(), params[controller_path])
  end

  def update
    process_form(SystemAssociation.find(params[controller_path][:id]), params[controller_path])
  end

end
