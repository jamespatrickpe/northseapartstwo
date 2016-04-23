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

  def process_digital_form(myDigital, my_ID = nil)
    begin
      myDigital[:url] = params[controller_path][:url]
      myDigital[:remark] = params[controller_path][:remark]
      myDigital.save!
      flash[:general_flash_notification_type] = 'affirmative'
      if action_name == 'update'
        flash[:general_flash_notification] = 'Updated' + ' ' + controller_name + ' | ' + my_ID
      elsif
        flash[:general_flash_notification] = 'Created New' + ' ' + controller_name
      else
        flash[:general_flash_notification] = 'Performed ' + action_name + ' ' + controller_name
      end
    rescue => ex
      puts ex.backtrace.to_s
      index_error(ex)
    end
    redirect_to :action => 'index'
  end

  def create
    myDigital = Digital.new()
    process_digital_form(myDigital)
  end

  def update
    myDigital = Digital.find(params[controller_path][:id])
    process_digital_form(myDigital, params[controller_path][:id])
  end

end