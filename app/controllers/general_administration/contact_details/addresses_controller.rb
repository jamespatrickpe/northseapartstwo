class GeneralAdministration::ContactDetails::AddressesController < GeneralAdministration::ContactDetailsController

  def index
    @addresses = initialize_generic_index(Address, [:addressable])
    render_index
  end

  def search_suggestions
    simple_singular_column_search('addresses.remark',Address)
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

  def process_address_form(myAddress)
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
    redirect_to_index
  end

  def create
    process_address_form(Address.new())
  end

  def update
    process_address_form(Address.find(params[controller_path][:id]))
  end

end