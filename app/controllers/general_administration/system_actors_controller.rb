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

  def process_actor_form(myActor)
    begin
      myActor[:name] = params[controller_path][:name]
      myActor[:remark] = params[controller_path][:remark]
      if action_name == 'edit'
        myImage.remove_logo
      end
      myActor.logo = params[controller_path][:logo]
      myActor.save!
      set_process_notification
    rescue => ex
      index_error(ex)
    end
    redirect_to_index
  end

  def create
    process_actor_form(SystemActor.new())
  end

  def update
    process_actor_form(SystemActor.find(params[controller_path][:id]))
  end

end
