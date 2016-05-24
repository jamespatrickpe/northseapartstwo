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

  def process_form(myAddress)
    begin
      myAddress[:remark] = params[controller_path][:remark]
      myAddress[:longitude] = params[controller_path][:longitude]
      myAddress[:latitude] = params[controller_path][:latitude]
      myAddress[:addressable_type] = params[controller_path][:addressable_type]
      myAddress[:addressable_id] = params[controller_path][:addressable_id]
      myAddress.save!
      set_process_notification
    rescue => ex
      index_error(ex)
    end
    form_completion_redirect
  end

  def create
    process_form(Address.new())
  end

  def update
    process_form(Address.find(params[controller_path][:id]))
  end

end