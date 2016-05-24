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

  def process_form(association)
    begin
      association[:remark] = params[controller_path][:remark]
      association[:model_one_type] = params[controller_path][:model_one_type]
      association[:model_one_id] = params[controller_path][:model_one_id]
      association[:model_two_type] = params[controller_path][:model_two_type]
      association[:model_two_id] = params[controller_path][:model_two_id]
      association.save!
      set_process_notification
    rescue => ex
      index_error(ex)
    end
      form_completion_redirect
  end

  def create
    process_form(SystemAssociation.new())
  end

  def update
    process_form(SystemAssociation.find(params[controller_path][:id]))
  end

end
