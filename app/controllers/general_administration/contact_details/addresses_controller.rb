class GeneralAdministration::ContactDetails::AddressesController < GeneralAdministration::ContactDetailsController

  def index
    initialize_generic_index(Address, 'Location of an Entity')
  end

  def search_suggestions
    generic_index_search_suggestions(Address)
  end

  def new
    set_new_edit(Address)
  end

  def edit
    set_new_edit(Address)
  end

  def show
    edit
  end

  def delete
    generic_delete(Address)
  end

  def process_form(myAddress, current_params, wizard_mode = nil)
    begin
      myAddress[:remark] = current_params[:remark]
      myAddress[:longitude] = current_params[:longitude]
      myAddress[:latitude] = current_params[:latitude]
      myAddress[:addressable_type] = current_params[:addressable_type]
      myAddress[:addressable_id] = current_params[:addressable_id]
      myAddress.save!
      set_process_notification unless wizard_mode
    rescue => ex
      index_error(ex, wizard_mode)
    end
    form_completion_redirect(wizard_mode)
  end

  def create
    process_form(Address.new(), params[controller_path])
  end

  def update
    process_form(Address.find(params[controller_path][:id]), params[controller_path])
  end

end