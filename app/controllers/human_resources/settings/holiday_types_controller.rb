class HumanResources::Settings::HolidayTypesController < HumanResources::SettingsController

  def index
    query = generic_index_aggregated_queries('holiday_types','holiday_types.created_at')
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

  def initialize_form
    initialize_form_variables('HOLIDAY TYPE',
                              'human_resources/settings/holiday_types/holiday_type_form',
                              'holiday_type')
    initialize_employee_selection
  end

  def new
    initialize_form
    @selected_holiday_type = HolidayType.new
    generic_form_main(@selected_holiday_type)
  end

  def edit
    initialize_form
    @selected_holiday_type = HolidayType.find(params[:id])
    generic_form_main(@selected_holiday_type)
  end

  def delete
    generic_delete_model(HolidayType, controller_name)
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
                        .where("holiday_types.type_name LIKE ?","%#{params[:query]}%")
                        .pluck("holiday_types.type_name")
    direct = "{\"query\": \"Unit\",\"suggestions\":[" + holiday_types.to_s.gsub!('[', '').gsub!(']', '') + "]}"
    respond_to do |format|
      format.all { render :text => direct}
    end
  end


end