class GeneralAdministrator::ContactDetails::DigitalsController < GeneralAdministrator::ContactDetailsController

  def index
    query = generic_table_aggregated_queries('digitals','digitals.created_at')
    begin
      @digitals = Digital
                       .where("digitals.url LIKE ? OR " +
                                  "digitals.description LIKE ? ",
                              "%#{query[:search_field]}%",
                              "%#{query[:search_field]}%")
                       .order(query[:order_parameter] + ' ' + query[:order_orientation])
      @digitals = Kaminari.paginate_array(@digitals).page(params[:page]).per(query[:current_limit])
    rescue => ex
      flash[:general_flash_notification] = "Error has Occured"
    end
    render 'general_administrator/contact_details/digitals/index'
  end

  def new
    @selected_digital = Digital.new
    @actors = Actor.all().order('name ASC')
    render 'general_administrator/contact_details/digitals/digital_form'
  end

  def edit
    @selected_digital = Digital.find(params[:id])
    @actors = Actor.all().order('name ASC')
    render 'general_administrator/contact_details/digitals/digital_form'
  end

  def delete
    digital_to_be_deleted = Digital.find(params[:id])
    flash[:general_flash_notification] = 'Digital information url:  ' + digital_to_be_deleted.url + ' has been deleted.'
    flash[:general_flash_notification_type] = 'affirmative'
    digital_to_be_deleted.destroy
    redirect_to :action => "index"
  end

  def process_digital_form(myDigital)
    begin
      myDigital[:url] = params[:digital][:url]
      myDigital[:actor_id] = params[:digital][:actor_id]
      myDigital[:description] = params[:digital][:description]
      myDigital.save!
      flash[:general_flash_notification_type] = 'affirmative'
    rescue => ex
      puts ex
      flash[:general_flash_notification] = 'Error Occurred. Please contact Administrator.' + ex.to_s
    end
    redirect_to :action => 'index'
  end

  def create
    myDigital = Digital.new()
    flash[:general_flash_notification] = 'Digital address information created!'
    process_digital_form(myDigital)
  end

  def update
    myDigital = Digital.find(params[:digital][:id])
    flash[:general_flash_notification] = 'Digital address information ' + params[:digital][:url]
    process_digital_form(myDigital)
  end

  def search_suggestions
    digitals = Digital
                    .where("digitals.url LIKE ?","%#{params[:query]}%")
                    .pluck("digitals.url")
    direct = "{\"query\": \"Unit\",\"suggestions\":[" + digitals.to_s.gsub!('[', '').gsub!(']', '') + "]}"
    respond_to do |format|
      format.all { render :text => direct}
    end
  end
end