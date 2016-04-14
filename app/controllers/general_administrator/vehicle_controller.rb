class GeneralAdministrator::VehicleController < GeneralAdministratorController


  def index
    query = generic_table_aggregated_queries('vehicles','vehicles.created_at')
    begin
      @vehicles = Vehicle
                      .where("vehicles.plate_number LIKE ? OR " +
                                 "vehicles.type_of_vehicle LIKE ?",
                             "%#{query[:search_field]}%",
                             "%#{query[:search_field]}%")
                      .order(query[:order_parameter] + ' ' + query[:order_orientation])
      @vehicles = Kaminari.paginate_array(@vehicles).page(params[:page]).per(query[:current_limit])
    rescue => ex
      flash[:general_flash_notification] = "Error has Occured" + ex.to_s
    end
    render '/general_administrator/vehicle/index'
  end


  def initialize_form
    initialize_form_variables('VEHICLE',
                              'general_administrator/vehicle/vehicle_form',
                              'vehicle')
    initialize_employee_selection
  end

  def search_suggestions
    vehicles = Vehicle
                   .where("vehicles.plate_number LIKE ?","%#{params[:query]}%")
                   .pluck("vehicles.plate_number")
    direct = "{\"query\": \"Unit\",\"suggestions\":[" + vehicles.to_s.gsub!('[', '').gsub!(']', '') + "]}"
    respond_to do |format|
      format.all { render :text => direct}
    end
  end

  def new
    initialize_form
    @selected_vehicle = Vehicle.new
    generic_single_column_form(@selected_vehicle)
  end

  def edit
    initialize_form
    @selected_vehicle = Vehicle.find(params[:id])
    generic_single_column_form(@selected_vehicle)
  end

  def delete
    generic_delete_model(Vehicle,controller_name)
  end

  def process_vehicle_form(myVehicle)
    begin
      myVehicle[:remark] = params[:vehicle][:remark]
      myVehicle[:date_of_registration] = params[:vehicle][:date_of_registration]
      myVehicle[:type_of_vehicle] = params[:vehicle][:type_of_vehicle]
      myVehicle[:plate_number] = params[:vehicle][:plate_number]
      myVehicle[:orcr] = params[:vehicle][:orcr]
      myVehicle.save!
      flash[:general_flash_notification_type] = 'affirmative'
    rescue => ex
      puts ex
      flash[:general_flash_notification] = 'Error Occurred. Please contact Administrator.' + ex.to_s
    end
    redirect_to :action => 'index'
  end

  def create
    myVehicle = Vehicle.new()
    flash[:general_flash_notification] = 'Vehicle Created!'
    process_vehicle_form(myVehicle)
  end

  def update
    myVehicle = Vehicle.find(params[:vehicle][:id])
    flash[:general_flash_notification] = 'Vehicle Updated: ' + params[:vehicle][:id]
    process_vehicle_form(myVehicle)
  end

end