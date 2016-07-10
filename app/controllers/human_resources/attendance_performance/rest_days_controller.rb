class HumanResources::AttendancePerformance::RestDaysController < HumanResources::AttendancePerformanceController

  def index
    initialize_generic_index(RestDay, 'Dedicated Rest Day for Employee under Labor Code')
  end

  def search_suggestions
    generic_index_search_suggestions(RestDay)
  end

  def new
    set_new_edit(RestDay)
  end

  def edit
    set_new_edit(RestDay)
  end

  def show
    edit
  end

  def delete
    generic_delete(RestDay)
  end

  def process_form(rest_day, current_params, wizard_mode = nil)
    begin
      rest_day[:day] = current_params[:day]
      rest_day[:date_of_implementation] = current_params[:date_of_implementation]
      rest_day[:employee_id] = current_params[:employee_id]
      rest_day.save!
      set_process_notification(current_params) unless wizard_mode
    rescue => ex
      index_error(ex, wizard_mode)
    end
    form_completion_redirect(wizard_mode)
  end

  def create
    process_form(RestDay.new(), params[controller_path])
  end

  def update
    process_form(RestDay.find(params[controller_path][:id]), params[controller_path])
  end

end
