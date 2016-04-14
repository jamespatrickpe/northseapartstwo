class GeneralAdministrator::ContactDetails::TelephonesController < GeneralAdministrator::ContactDetailsController

  def index
    query = generic_table_aggregated_queries('telephones','telephones.created_at')
    begin
      @telephones = Telephone
                      .where("telephones.digits LIKE ? OR " +
                                 "telephones.description LIKE ? ",
                             "%#{query[:search_field]}%",
                             "%#{query[:search_field]}%")
                      .order(query[:order_parameter] + ' ' + query[:order_orientation])
      @telephones = Kaminari.paginate_array(@telephones).page(params[:page]).per(query[:current_limit])
    rescue => ex
      flash[:general_flash_notification] = "Error has Occured"
    end
    render 'general_administrator/contact_details/telephones/index'
  end


  def initialize_form
    initialize_form_variables('TELEPHONE',
                              'general_administrator/contact_details/telephones/telephone_form',
                              'telephone')
    initialize_employee_selection
  end

  def new
    initialize_form
    @selected_telephone = Telephone.new
    @actors1 = Actor.all()
    @actors2 = Branch.all()
    generic_single_column_form(@selected_telephone)
  end

  def edit
    initialize_form
    @selected_telephone = Telephone.find(params[:id])
    @actorsInvolved ||= []

    # @telephone_actor_rel = TelephonesActor.find_by_telephone_id(params[:id])
    @telephone_actor_rel = TelephonesActor.where("telephones_actors.telephone_id = ?", "#{params[:id]}")

    involvedActorObjects ||= []
    involvedBranchObjects ||= []

    @telephone_actor_rel.each do |ea|
      if Actor.exists?(ea[:actor_id])
        involvedActorObjects.push(Actor.find(ea[:actor_id]))
      else
        puts 'ID in use does not belong to an Actor'
      end
    end

    @telephone_actor_rel.each do |ea|
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

    generic_single_column_form(@selected_telephone)
  end

  def delete
    telephone_to_be_deleted = Telephone.find(params[:id])
    flash[:general_flash_notification] = 'Telephone information :  ' + telephone_to_be_deleted.digits + ' has been deleted.'
    flash[:general_flash_notification_type] = 'affirmative'

    # deletes all related actors with the telephone before deleting the actual telephone object
    mapped_telephone_actors = TelephonesActor.where("telephones_actors.telephone_id = ?", "#{params[:id]}")
    mapped_telephone_actors.each do |a|
      a.destroy
    end


    telephone_to_be_deleted.destroy
    redirect_to :action => "index"
  end

  def process_telephone_form(myTelephone)
    begin
      myTelephone[:digits] = params[:telephone][:digits]
      myTelephone[:description] = params[:telephone][:description]
      myTelephone.save!

      # after creating the new telephone, iterate through all the actors involved and maps them with the telephone
      actorsInvolved = params[:telephone][:telephoneactors]
      actorsInvolved.each_with_index do |p , index|
        actor = TelephonesActor.new
        actor[:actor_id] = actorsInvolved.values[index]
        actor[:telephone_id] = myTelephone.id
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
    myTelephone = Telephone.new()
    flash[:general_flash_notification] = 'Telephone information created!'
    process_telephone_form(myTelephone)
  end

  def update
    myTelephone = Telephone.find(params[:telephone][:id])
    flash[:general_flash_notification] = 'Telephone information ' + params[:telephone][:digits] + ' has been updated.'
    process_telephone_form(myTelephone)
  end

  def search_suggestions
    telephones = Telephone
                   .where("telephones.digits LIKE ?","%#{params[:query]}%")
                   .pluck("telephones.digits")
    direct = "{\"query\": \"Unit\",\"suggestions\":[" + telephones.to_s.gsub!('[', '').gsub!(']', '') + "]}"
    respond_to do |format|
      format.all { render :text => direct}
    end
  end
end