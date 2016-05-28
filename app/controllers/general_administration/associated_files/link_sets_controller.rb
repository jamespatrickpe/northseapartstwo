class GeneralAdministration::AssociatedFiles::LinkSetsController < GeneralAdministration::AssociatedFilesController

  def index
    initialize_generic_index(LinkSet, 'Link Sets')
  end

  def search_suggestions
    generic_index_search_suggestions(LinkSet)
  end

  def new
    set_new_edit(LinkSet)
  end

  def edit
    set_new_edit(LinkSet)
  end

  def show
    edit
  end

  def delete
    generic_delete(LinkSet)
  end

  def process_form(my_link_set, current_params, wizard_mode = nil)
    begin
      my_link_set[:url] = current_params[:url]
      my_link_set[:remark] = current_params[:remark]
      my_link_set[:linksetable_type] = current_params[:linksetable_type]
      my_link_set[:linksetable_id] = current_params[:linksetable_id]
      my_link_set.save!
      set_process_notification(current_params)
    rescue => ex
      index_error(ex,wizard_mode)
    end
    form_completion_redirect(wizard_mode)
  end

  def create
    process_form(LinkSet.new(), params[controller_path])
  end

  def update
    process_form(LinkSet.find(params[controller_path][:id]), params[controller_path])
  end

end