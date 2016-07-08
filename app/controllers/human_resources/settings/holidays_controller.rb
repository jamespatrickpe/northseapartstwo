class HumanResources::Settings::HolidaysController < HumanResources::SettingsController

  def index
    initialize_generic_index(Holiday, 'A day set aside by custom or by law on which normal activities, especially business or work, are suspended or reduced.')
  end

  def search_suggestions
    generic_index_search_suggestions(Holiday)
  end

  def new
    set_new_edit(Holiday)
  end

  def edit
    set_new_edit(Holiday)
  end

  def show
    edit
  end

  def delete
    generic_delete(Holiday)
  end

  def process_form(my_holiday, current_params, wizard_mode = nil)
    begin
      my_holiday[:remark] = current_params[:remark]
      my_holiday[:date_of_implementation] = current_params[:date_of_implementation]
      my_holiday[:name] = current_params[:name]
      my_holiday[:holiday_type_id] = current_params[:holiday_type_id]
      my_holiday.save!
      set_process_notification(current_params) unless wizard_mode
    rescue => ex
      index_error(ex, wizard_mode)
    end
    form_completion_redirect(wizard_mode)
  end

  def create
    process_form(Holiday.new(), params[controller_path])
  end

  def update
    process_form(Holiday.find(params[controller_path][:id]), params[controller_path])
  end


end
