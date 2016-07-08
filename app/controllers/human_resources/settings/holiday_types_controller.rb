class HumanResources::Settings::HolidayTypesController < HumanResources::SettingsController

  def index
    initialize_generic_index(HolidayType, 'A day set aside by custom or by law on which normal activities, especially business or work, are suspended or reduced.')
  end

  def search_suggestions
    generic_index_search_suggestions(HolidayType)
  end

  def new
    set_new_edit(HolidayType)
  end

  def edit
    set_new_edit(HolidayType)
  end

  def show
    edit
  end

  def delete
    generic_delete(HolidayType)
  end

  def process_form(my_holiday_type, current_params, wizard_mode = nil)
    begin
      my_holiday_type[:type_name] = current_params[:type_name]
      my_holiday_type[:rate_multiplier] = current_params[:rate_multiplier]
      my_holiday_type[:overtime_multiplier] = current_params[:overtime_multiplier]
      my_holiday_type[:rest_day_multiplier] = current_params[:rest_day_multiplier]
      my_holiday_type[:overtime_rest_day_multiplier] = current_params[:overtime_rest_day_multiplier]
      my_holiday_type[:no_work_pay] = current_params[:no_work_pay]
      my_holiday_type.save!
      set_process_notification(current_params) unless wizard_mode
    rescue => ex
      index_error(ex, wizard_mode)
    end
    form_completion_redirect(wizard_mode)
  end

  def create
    process_form(HolidayType.new(), params[controller_path])
  end

  def updates
    process_form(HolidayType.find(params[controller_path][:id]), params[controller_path])
  end


end