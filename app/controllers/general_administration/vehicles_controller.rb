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

  def process_form(myVehicle)
    begin
      myVehicle[:oil] = params[controller_path][:oil]
      myVehicle[:capacity_m3] = params[controller_path][:capacity_m3]
      myVehicle[:brand] = params[controller_path][:brand]
      myVehicle[:date_of_implementation] = params[controller_path][:date_of_implementation]
      myVehicle[:plate_number] = params[controller_path][:plate_number]
      myVehicle[:type_of_vehicle] = params[controller_path][:type_of_vehicle]
      myVehicle[:remark] = params[controller_path][:remark]
      myVehicle.save!
      set_process_notification
    rescue => ex
      index_error(ex)
    end

    form_completion_redirect
  end

  def create
    process_form(Vehicle.new())
  end

  def update
    process_form(Vehicle.find(params[controller_path][:id]))
  end

end