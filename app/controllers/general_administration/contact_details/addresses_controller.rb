class GeneralAdministration::ContactDetails::AddressesController < GeneralAdministration::ContactDetailsController

  def index
    @addresses = initialize_generic_table(Address, [:digitable])
    render_index
  end

  def search_suggestions
    simple_singular_column_search('addresses.remark',Digital)
  end

  def new
    initialize_form
    @selected_address = Address.new
    generic_single_column_form(@selected_address)
  end

  def edit
    initialize_form
    @selected_address = Address.find(params[:id])
    generic_single_column_form(@selected_address)
  end

  def show
    edit
  end

  def delete
    Address.find(params[:id]).destroy
    redirect_to :action => "index"
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
    render_index
  end

  def create
    myAddress = Address.new()
    process_address_form(myAddress)
  end

  def update
    myAddress = Address.find(params[:address][:id])
    process_address_form(myAddress)
  end

end