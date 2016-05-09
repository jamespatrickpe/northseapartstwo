class HumanResources::Settings::HolidaysController < HumanResources::SettingsController

  def index
    query = generic_index_aggregated_queries('holidays','holidays.created_at')
    begin
      @holidays = Holiday
      .includes(:holiday_type).joins(:holiday_type)
      .where("holidays.id LIKE ? OR " +
                 "holiday_types.type_name LIKE ? OR " +
                 "holidays.remark LIKE ? OR " +
                 "holidays.name LIKE ? OR " +
                 "holidays.remark LIKE ? OR " +
                 "holidays.date_of_implementation LIKE ? OR " +
                 "holidays.created_at LIKE ? OR " +
                 "holidays.updated_at LIKE ? ",
             "%#{query[:search_field]}%",
             "%#{query[:search_field]}%",
             "%#{query[:search_field]}%",
             "%#{query[:search_field]}%",
             "%#{query[:search_field]}%",
             "%#{query[:search_field]}%",
             "%#{query[:search_field]}%",
             "%#{query[:search_field]}%")
      .order(query[:order_parameter] + ' ' + query[:order_orientation])
      @holidays = Kaminari.paginate_array(@holidays).page(params[:page]).per(query[:current_limit])
    rescue => ex
      flash[:general_flash_notification] = "Error has Occured" + ex.to_s
    end
    render 'human_resources/settings/holidays/index'
  end

  def initialize_form
    initialize_form_variables('HOLIDAYS',
                              'human_resources/settings/holidays/holiday_form',
                              'holiday')
    initialize_employee_selection
  end

  def new
    initialize_form
    @selected_holiday = Holiday.new
    @holiday_types = HolidayType.all
    generic_form_main(@selected_holiday)
  end

  def edit
    initialize_form
    @selected_holiday = Holiday.find(params[:id])
    @holiday_types = HolidayType.all
    generic_form_main(@selected_holiday)
  end

  def delete
    generic_delete_model(Holiday, controller_name)
  end

  def process_holiday_form(myHoliday)
    begin
      myHoliday[:holiday_type_id] = params[:holiday][:holiday_type_id]
      myHoliday[:remark] = params[:holiday][:remark]
      myHoliday[:name] = params[:holiday][:name]
      myHoliday[:date_of_implementation] = params[:holiday][:date_of_implementation]
      myHoliday.save!
      flash[:general_flash_notification_type] = 'affirmative'
    rescue => ex
      flash[:general_flash_notification] = 'Error Occurred. Please contact Administrator.' + ex.to_s
    end
    redirect_to :action => 'index'
  end

  def create
    myHoliday = Holiday.new()
    flash[:general_flash_notification] = 'Holiday Created!'
    process_holiday_form(myHoliday)
  end

  def update
    myHoliday = Holiday.find(params[:holiday][:id])
    flash[:general_flash_notification] = 'Holiday Updated: ' + params[:holiday][:id]
    process_holiday_form(myHoliday)
  end

  def search_suggestions
    holidays = Holiday
    .includes(:holiday_type)
    .joins(:holiday_type)
    .where("holidays.name LIKE ?","%#{params[:query]}%")
    .pluck("holidays.name")
    direct = "{\"query\": \"Unit\",\"suggestions\":[" + holidays.to_s.gsub!('[', '').gsub!(']', '') + "]}"
    respond_to do |format|
      format.all { render :text => direct}
    end
  end

  def check_unique_holiday_date
    date_of_implementation_exists = Holiday.exists?(date_of_implementation: params[:holiday][:date_of_implementation])
    respond_to do |format|
      format.json { render json: {:"exists" => date_of_implementation_exists}.to_json }
    end
  end

end
