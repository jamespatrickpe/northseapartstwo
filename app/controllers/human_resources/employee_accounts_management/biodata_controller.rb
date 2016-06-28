class HumanResources::EmployeeAccountsManagement::BiodataController < HumanResources::EmployeeAccountsManagementController

  def index
    initialize_generic_index(Biodatum, 'Information regarding an individual\'s education and work history')
  end

  def search_suggestions
    generic_index_search_suggestions(Biodatum)
  end

  def new
    set_new_edit(Biodatum)
  end

  def edit
    set_new_edit(Biodatum)
  end

  def show
    edit
  end

  def delete
    generic_delete(Biodatum)
  end

  def process_biodatum_form(my_biodatum, current_params, wizard_mode = nil)
    begin
      my_biodatum.actor_id = Employee.find(params[:employee_id]).actor_id
      my_biodatum.education = current_params[:education]
      my_biodatum.career_experience = current_params[:career_experience]
      my_biodatum.notable_accomplishments = current_params[:notable_accomplishments]
      my_biodatum.date_of_birth = current_params[:date_of_birth]
      my_biodatum.family_members = current_params[:family_members]
      my_biodatum.citizenship = current_params[:citizenship]
      my_biodatum.gender = current_params[:gender]
      my_biodatum.place_of_birth = current_params[:place_of_birth]
      my_biodatum.emergency_contact = current_params[:emergency_contact]
      my_biodatum.languages_spoken = current_params[:languages_spoken]
      my_biodatum.complexion = current_params[:complexion]
      my_biodatum.height_cm = current_params[:height_cm]
      my_biodatum.marital_status = current_params[:marital_status]
      my_biodatum.blood_type = current_params[:blood_type]
      my_biodatum.religion = current_params[:religion]
      my_biodatum.save!
      set_process_notification(current_params) unless wizard_mode
    rescue => ex
      index_error(ex, wizard_mode)
    end
    form_completion_redirect(wizard_mode)
  end

  def create
    process_form(Biodatum.new(), params[controller_path])
  end

  def update
    process_form(Biodatum.find(params[controller_path][:id]), params[controller_path])
  end

end
