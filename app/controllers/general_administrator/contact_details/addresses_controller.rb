class GeneralAdministrator::ContactDetails::AddressesController < GeneralAdministrator::ContactDetailsController

  def index
    query = generic_table_aggregated_queries('addresses','addresses.created_at')
    begin
      @addresses = Address
                      .where("addresses.longitude LIKE ? OR " +
                                 "addresses.latitude LIKE ? OR " +
                                 "addresses.description LIKE ? ",
                             "%#{query[:search_field]}%",
                             "%#{query[:search_field]}%",
                             "%#{query[:search_field]}%")
                      .order(query[:order_parameter] + ' ' + query[:order_orientation])
      @addresses = Kaminari.paginate_array(@addresses).page(params[:page]).per(query[:current_limit])
    rescue => ex
      flash[:general_flash_notification] = "Error has Occured"
    end
    render 'general_administrator/contact_details/addresses/index'
  end

  def initialize_form
    initialize_form_variables('ADDRESS',
                              'Create a new address entry into the system',
                              'general_administrator/contact_details/addresses/address_form',
                              'address')
    initialize_employee_selection
  end

  def new
    initialize_form
    @selected_address = Address.new
    @actors = Actor.all().order('name ASC')
    generic_singlecolumn_form(@selected_address)
  end

  def edit
    initialize_form
    @selected_address = Address.find(params[:id])
    @actors = Actor.all().order('name ASC')
    generic_singlecolumn_form(@selected_address)
  end

  def delete
    address_to_be_deleted = Address.find(params[:id])
    flash[:general_flash_notification] = 'Address ' + address_to_be_deleted.description + ' has been deleted.'
    flash[:general_flash_notification_type] = 'affirmative'
    address_to_be_deleted.destroy
    redirect_to :action => "index"
  end

  def process_address_form(myAddress)
    begin
      myAddress[:description] = params[:address][:description]
      myAddress[:longitude] = params[:address][:longitude]
      myAddress[:latitude] = params[:address][:latitude]
      myAddress[:rel_model_type] = params[:address][:rel_model_type]
      myAddress[:rel_model_id] = params[:address][:rel_model_id]
      myAddress.save!
      flash[:general_flash_notification_type] = 'affirmative'
    rescue => ex
      flash[:general_flash_notification] = 'Error Occurred. Please contact Administrator.' + ex.to_s
    end
    redirect_to :action => 'index'
  end

  def create
    myAddress = Address.new()
    flash[:general_flash_notification] = 'Address Created!'
    process_address_form(myAddress)
  end

  def update
    myAddress = Address.find(params[:address][:id])
    flash[:general_flash_notification] = 'Address Updated: ' + params[:address][:id]
    process_address_form(myAddress)
  end

  def search_suggestions
    addresses = Address
                   .where("addresses.description LIKE ?","%#{params[:query]}%")
                   .pluck("addresses.description")
    direct = "{\"query\": \"Unit\",\"suggestions\":[" + addresses.to_s.gsub!('[', '').gsub!(']', '') + "]}"
    respond_to do |format|
      format.all { render :text => direct}
    end
  end
end