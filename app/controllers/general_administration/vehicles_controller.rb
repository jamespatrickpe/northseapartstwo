class GeneralAdministration::VehiclesController < GeneralAdministrationController

  def index
    @vehicles = initialize_generic_table(Vehicle)
    render_index
  end

  def search_suggestions
    simple_singular_column_search('Vehicle.plate_number',Vehicle)
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

  def process_vehicle_form(myVehicle)
    begin
      myVehicle[:orcr] = params[controller_path][:orcr]
      myVehicle[:plate_number] = params[controller_path][:plate_number]
      myVehicle[:date_of_implementation] = params[controller_path][:date_of_implementation]
      myVehicle[:type_of_vehicle] = params[controller_path][:type_of_vehicle]
      myVehicle[:remark] = params[controller_path][:remark]
      myVehicle.save!
      set_process_notification
    rescue => ex
      index_error(ex)
    end
    redirect_to_index
  end

  def create
    process_digital_form(Vehicle.new())
  end

  def update
    process_digital_form(Vehicle.find(params[controller_path][:id]))
  end

end