class GeneralAdministration::ContactDetails::TelephonesController < GeneralAdministration::ContactDetailsController

  def index
    initialize_generic_index(Telephone, 'Contact Details through Telephony')
  end

  def search_suggestions
    generic_index_search_suggestions(Telephone)
  end

  def new
    set_new_edit(Telephone)
  end

  def edit
    set_new_edit(Telephone)
  end

  def show
    edit
  end

  def delete
    generic_delete(Telephone)
  end

  def process_form(my_telephone, current_params, wizard_mode = nil)
    begin
      my_telephone[:digits] = current_params[:digits]
      my_telephone[:remark] = current_params[:remark]
      my_telephone[:telephonable_type] = current_params[:telephonable_type]
      my_telephone[:telephonable_id] = current_params[:telephonable_id]
      my_telephone.save!
      set_process_notification(current_params) unless wizard_mode
    rescue => ex
      index_error(ex, wizard_mode)
    end
    form_completion_redirect(wizard_mode)
  end

  def create
    process_form(Telephone.new(), params[controller_path])
  end

  def update
    process_form(Telephone.find(params[controller_path][:id]), params[controller_path])
  end

end