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
      flash[:general_flash_notification_type] = 'affirmative'
      if( params[:digital][:id] )
        flash[:general_flash_notification] = 'Digital address information ' + params[:digital][:url].to_s
      else
        flash[:general_flash_notification] = 'Digital address information created!'
      end
    rescue => ex
      index_error(ex)
    end
    redirect_to :action => 'index'
  end

  def create
    myDigital = Digital.new()
    process_digital_form(myDigital)
  end

  def update
    myDigital = Digital.find(params[:digital][:id])
    process_digital_form(myDigital)
  end

end