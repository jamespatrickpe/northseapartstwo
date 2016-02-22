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
    @actors1 = Actor.all()
    @actors2 = Branch.all()
    generic_singlecolumn_form(@selected_address)
  end

  def edit
    initialize_form
    @selected_address = Address.find(params[:id])
    @actorsInvolved ||= []

    # @address_actor_rel = TelephonesActor.find_by_address_id(params[:id])
    @address_actor_rel = AddressesActor.where("addresses_actors.address_id = ?", "#{params[:id]}")

    involvedActorObjects ||= []
    involvedBranchObjects ||= []

    @address_actor_rel.each do |ea|
      if Actor.exists?(ea[:actor_id])
        involvedActorObjects.push(Actor.find(ea[:actor_id]))
      else
        puts 'ID in use does not belong to an Actor'
      end
    end

    @address_actor_rel.each do |ea|
      if Branch.exists?(ea[:actor_id])
        involvedBranchObjects.push(Branch.find(ea[:actor_id]))
      else
        puts 'ID in use does not belong to a Branch'
      end
    end

    @actorsInvolved = involvedActorObjects + involvedBranchObjects

    @actorsInvolved.compact.uniq!

    @actors1 = Actor.all()
    @actors2 = Branch.all()
    generic_singlecolumn_form(@selected_address)
  end

  def delete
    address_to_be_deleted = Address.find(params[:id])
    flash[:general_flash_notification] = 'Address ' + address_to_be_deleted.description + ' has been deleted.'
    flash[:general_flash_notification_type] = 'affirmative'

    # deletes all related actors with the address before deleting the actual address object
    mapped_address_actors = AddressesActor.where("addresses_actors.address_id = ?", "#{params[:id]}")
    mapped_address_actors.each do |a|
      a.destroy
    end

    address_to_be_deleted.destroy
    redirect_to :action => "index"
  end

  def process_address_form(myAddress)
    begin
      myAddress[:description] = params[:address][:description]
      myAddress[:longitude] = params[:address][:longitude]
      myAddress[:latitude] = params[:address][:latitude]
      myAddress.save!

      # after creating the new address, iterate through all the actors involved and maps them with the address
      actorsInvolved = params[:address][:addressactors]
      actorsInvolved.each_with_index do |p , index|
        actor = AddressesActor.new
        actor[:actor_id] = actorsInvolved.values[index]
        actor[:address_id] = myAddress.id
        actor.save!
      end

      flash[:general_flash_notification_type] = 'affirmative'
    rescue => ex
      puts ex
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