class GeneralAdministration::SystemAccountsController < GeneralAdministrationController

  def index
    initialize_generic_index(SystemAccount, 'Entities that interact with the System')
  end

  def search_suggestions
    generic_index_search_suggestions(SystemAccount)
  end

  def new
    set_new_edit(SystemAccount)
  end

  def edit
    set_new_edit(SystemAccount)
  end

  def show
    edit
  end

  def delete
    SystemAccount.find(params[:id]).remove_logo
    generic_delete(SystemAccount)
  end

  def process_form(my_actor, current_params, wizard_mode = nil)
    begin
      my_actor[:name] = current_params[:name]
      my_actor[:remark] = current_params[:remark]
      my_actor.remove_logo if action_name == 'edit'
      my_actor.logo = current_params[:logo]
      my_actor.save!
      set_process_notification(current_params) unless wizard_mode
    rescue => ex
      index_error(ex, wizard_mode)
    end
    form_completion_redirect(wizard_mode)
  end

  def create
    process_form(SystemAccount.new(), params[controller_path])
  end

  def update
    process_form(SystemAccount.find(params[controller_path][:id]), params[controller_path])
  end

end
