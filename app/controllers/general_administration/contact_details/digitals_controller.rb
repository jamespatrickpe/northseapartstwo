class GeneralAdministration::ContactDetails::DigitalsController < GeneralAdministration::ContactDetailsController

  def index
    @digitals = initialize_generic_table(Digital, [:digitable])
    render_index
  end

  def search_suggestions
    simple_singular_column_search('digitals.url',Digital)
  end

  def new
    initialize_form
    @selected_digital = Digital.new
    generic_single_column_form(@selected_digital)
  end

  def edit
    initialize_form
    @selected_digital = Digital.find(params[:id])
    generic_single_column_form(@selected_digital)
  end

  def delete
    Digital.find(params[:id]).destroy
    redirect_to :action => "index"
  end

  def process_digital_form(myDigital)
    begin
      myDigital[:url] = params[:digital][:url]
      myDigital[:remark] = params[:digital][:remark]
      myDigital.save!

      # after creating the new digital, iterate through all the actors involved and maps them with the digital
      actorsInvolved = params[:digital][:digitalactors]
      actorsInvolved.each_with_index do |p , index|
        actor = DigitalsActor.new
        actor[:actor_id] = actorsInvolved.values[index]
        actor[:digital_id] = myDigital.id
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
    myDigital = Digital.new()
    flash[:general_flash_notification] = 'Digital address information created!'
    process_digital_form(myDigital)
  end

  def update
    myDigital = Digital.find(params[:digital][:id])
    flash[:general_flash_notification] = 'Digital address information ' + params[:digital][:url]
    process_digital_form(myDigital)
  end

end