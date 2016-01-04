class HumanResources::Settings::HolidayTypesController < HumanResources::SettingsController

  def index
    query = generic_table_aggregated_queries('holiday_types','holiday_types.created_at')
    begin
      @holiday_types = HolidayType
      .where("holiday_types.id LIKE ? OR " +
                 "holiday_types.type_name LIKE ? OR " +
                 "holiday_types.rate_multiplier LIKE ? OR " +
                 "holiday_types.overtime_multiplier LIKE ? OR " +
                 "holiday_types.rest_day_multiplier LIKE ? OR " +
                 "holiday_types.overtime_rest_day_multiplier LIKE ? OR " +
                 "holiday_types.no_work_pay LIKE ? OR " +
                 "holiday_types.created_at LIKE ? OR " +
                 "holiday_types.updated_at LIKE ? ",
             "%#{query[:search_field]}%",
             "%#{query[:search_field]}%",
             "%#{query[:search_field]}%",
             "%#{query[:search_field]}%",
             "%#{query[:search_field]}%",
             "%#{query[:search_field]}%",
             "%#{query[:search_field]}%",
             "%#{query[:search_field]}%",
             "%#{query[:search_field]}%")
      .order(query[:order_parameter] + ' ' + query[:order_orientation])
      @holiday_types = Kaminari.paginate_array(@holiday_types).page(params[:page]).per(query[:current_limit])
    rescue => ex
      flash[:general_flash_notification] = "Error has Occured" + ex.to_s
    end
    render 'human_resources/settings/holiday_types/index'
  end

  def new
    @selected_holiday_type = HolidayType.new
    render 'human_resources/settings/holiday_types/holiday_type_form'
  end

  def edit
    @selected_holiday_type = HolidayType.find(params[:id])
    render 'human_resources/settings/holiday_types/holiday_type_form'
  end

  def delete
    holiday_types_to_be_deleted = HolidayType.find(params[:id])
    flash[:general_flash_notification] = 'A Holiday Type for ' + holiday_types_to_be_deleted[:type_name] + ' has been deleted.'
    flash[:general_flash_notification_type] = 'affirmative'
    holiday_types_to_be_deleted.destroy
    redirect_to :action => 'index'
  end

  def process_holiday_type_form(myHolidayType)
    begin
      myHolidayType[:type_name] = params[:holiday_type][:type_name]
      myHolidayType[:rate_multiplier] = params[:holiday_type][:rate_multiplier]
      myHolidayType[:overtime_multiplier] = params[:holiday_type][:overtime_multiplier]
      myHolidayType[:rest_day_multiplier] = params[:holiday_type][:rest_day_multiplier]
      myHolidayType[:overtime_rest_day_multiplier] = params[:holiday_type][:overtime_rest_day_multiplier]
      myHolidayType[:no_work_pay] = params[:holiday_type][:no_work_pay]
      myHolidayType.save!
      flash[:general_flash_notification_type] = 'affirmative'
    rescue => ex
      flash[:general_flash_notification] = 'Error Occurred. Please contact Administrator.'
    end
    redirect_to :action => 'index'
  end

  def create
    myHolidayType = HolidayType.new()
    flash[:general_flash_notification] = 'Holiday Type Created!'
    process_holiday_type_form(myHolidayType)
  end

  def update
    myHolidayType = HolidayType.find(params[:holiday_type][:id])
    flash[:general_flash_notification] = 'Holiday Type Updated: ' + params[:holiday_type][:id]
    process_holiday_type_form(myHolidayType)
  end

  def search_suggestions
    holiday_types = HolidayType
    .includes(:holiday_type)
    .joins(:holiday_type)
    .where("holiday_types.type_name LIKE ?","%#{params[:query]}%")
    .pluck("holiday_types.type_name")
    direct = "{\"query\": \"Unit\",\"suggestions\":[" + holiday_types.to_s.gsub!('[', '').gsub!(']', '') + "]}"
    respond_to do |format|
      format.all { render :text => direct}
    end
  end

end