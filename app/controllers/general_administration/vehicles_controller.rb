class GeneralAdministration::VehiclesController < GeneralAdministrationController

  def index
    initialize_generic_index(Vehicle, 'Transportation Assets')
  end

  def search_suggestions
    generic_index_search_suggestions(Vehicle)
  end

  def new
    set_new_edit(Vehicle)
  end

  def edit
    set_new_edit(Vehicle)
  end

  def show
    edit
  end

  def delete
    generic_delete(Vehicle)
  end

  def process_form(my_vehicle, current_params, wizard_mode = nil)
    begin
      my_vehicle[:oil] = current_params[:oil]
      my_vehicle[:capacity_m3] = current_params[:capacity_m3]
      my_vehicle[:brand] = current_params[:brand]
      my_vehicle[:date_of_implementation] = current_params[:date_of_implementation]
      my_vehicle[:plate_number] = current_params[:plate_number]
      my_vehicle[:type_of_vehicle] = current_params[:type_of_vehicle]
      my_vehicle[:remark] = current_params[:remark]
      my_vehicle.save!
      set_process_notification
    rescue => ex
      index_error(ex, wizard_mode)
    end
    form_completion_redirect(wizard_mode)
  end

  def create
    process_form(Vehicle.new(), params[controller_path])
  end

  def update
    process_form(Vehicle.find(params[controller_path][:id]), params[controller_path])
  end

end