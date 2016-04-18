class HumanResources::EmployeeAccountsManagement::BiodataController < HumanResources::EmployeeAccountsManagementController

  def index
    query = generic_table_aggregated_queries('biodata','biodata.created_at')
    begin
      @biodata = Biodatum.includes(:actor)
                           .joins(:actors)
                           .where("biodata.actor_id LIKE ? ",
                                  "%#{query[:search_field]}%")
                           .order(query[:order_parameter] + ' ' + query[:order_orientation])
      @biodata = Kaminari.paginate_array(@biodata).page(params[:page]).per(query[:current_limit])
    rescue => ex
      flash[:general_flash_notification] = "Error has Occured"
    end
    render 'human_resources/employee_accounts_management/biodata/index'
  end

  def initialize_form
    initialize_form_variables('BIODATA',
                              'human_resources/employee_accounts_management/biodata/biodatum_form',
                              'biodata')
    initialize_employee_selection
    @actors = Actor.all()
  end

  def new
    initialize_form
    @selected_biodata = Biodatum.new
    generic_tricolumn_form_with_employee_selection(@selected_biodata)
  end

  def edit
    initialize_form
    @selected_biodata = Biodatum.find(params[:id])
    generic_tricolumn_form_with_employee_selection(@selected_biodata)
  end

  def delete
    generic_delete_model(Biodatum,controller_name)
  end

  def search_suggestions
    generic_employee_name_search_suggestions(Biodatum)
  end

  def process_biodatum_form(myBiodatum)
    begin

      # since the selector used was for employees, we get the employee first and then get his/her actor_id
      # this is because biodata has actor_id column on db, not employee_id
      myBiodatum.actor_id = Employee.find(params[:biodata][:employee_id]).actor_id

      myBiodatum.education = params[:biodata][:education]
      myBiodatum.career_experience = params[:biodata][:career_experience]
      myBiodatum.notable_accomplishments = params[:biodata][:notable_accomplishments]
      myBiodatum.date_of_birth = params[:biodata][:date_of_birth]
      myBiodatum.family_members = params[:biodata][:family_members]
      myBiodatum.citizenship = params[:biodata][:citizenship]
      myBiodatum.gender = params[:biodata][:gender]
      myBiodatum.place_of_birth = params[:biodata][:place_of_birth]
      myBiodatum.emergency_contact = params[:biodata][:emergency_contact]
      myBiodatum.languages_spoken = params[:biodata][:languages_spoken]
      myBiodatum.complexion = params[:biodata][:complexion]
      myBiodatum.height_cm = params[:biodata][:height_cm]
      myBiodatum.marital_status = params[:biodata][:marital_status]
      myBiodatum.blood_type = params[:biodata][:blood_type]
      myBiodatum.religion = params[:biodata][:religion]
      myBiodatum.save!
      flash[:general_flash_notification_type] = 'affirmative'
    rescue => ex
      puts ex
      flash[:general_flash_notification] = 'Error Occurred. Please contact Administrator.'
    end
    redirect_to :action => 'index'
  end

  def create
    myBiodatum = Biodatum.new()
    flash[:general_flash_notification] = 'Biodata set and added!'
    process_biodatum_form(myBiodatum)
  end

  def update
    myBiodatum = Biodatum.find(params[:biodata][:id])
    flash[:general_flash_notification] = 'Biodata successfully updated!'
    process_biodatum_form(myBiodatum)
  end

end
