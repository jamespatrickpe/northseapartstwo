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

  def new
    @selected_telephone = Telephone.new
    render 'general_administrator/contact_details/telephones/telephone_form'
  end

  def edit
    @selected_telephone = Telephone.find(params[:id])
    render 'general_administrator/contact_details/telephones/telephone_form'
  end

  def delete
    telephone_to_be_deleted = Telephone.find(params[:id])
    flash[:general_flash_notification] = 'Telephone information :  ' + telephone_to_be_deleted.digits + ' has been deleted.'
    flash[:general_flash_notification_type] = 'affirmative'
    telephone_to_be_deleted.destroy
    redirect_to :action => "index"
  end

  def process_telephone_form(myTelephone)
    begin
      myTelephone[:digits] = params[:telephone][:digits]
      myTelephone[:description] = params[:telephone][:description]
      myTelephone.save!
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