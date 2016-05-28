class GeneralAdministration::SystemActorsController < GeneralAdministrationController

  def index
    initialize_generic_index(SystemActor, 'Entities that interact with the System')
  end

  def search_suggestions
    generic_index_search_suggestions(SystemActor)
  end

  def new
    set_new_edit(SystemActor)
  end

  def edit
    set_new_edit(SystemActor)
  end

  def show
    edit
  end

  def delete
    SystemActor.find(params[:id]).remove_logo
    generic_delete(SystemActor)
  end

  def process_form(myActor, wizard_params = nil)
    begin
      myActor[:name] = process_parameter(wizard_params, params[controller_path], 'name')
      myActor[:remark] = process_parameter(wizard_params, params[controller_path], 'remark')
      myActor.remove_logo if action_name == 'edit'
      myActor.logo = process_parameter(wizard_params, params[controller_path], 'logo')
      myActor.save!
      set_process_notification
    rescue => ex
      index_error(ex, wizard_params)
    end
    form_completion_redirect(wizard_params)
  end

  def create
    process_form(SystemActor.new())
  end

  def update
    process_form(SystemActor.find(params[controller_path][:id]))
  end


  def sample_process
    @sherwin = 'hueh hueh'
  end

end
