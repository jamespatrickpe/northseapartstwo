class GeneralAdministration::ActorsController < GeneralAdministrationController

  def index
    @actors = initialize_generic_table(Actor)
    render_index
  end

  def search_suggestions
    simple_singular_column_search('actors.remark',Actor)
  end

  def new
    set_new_edit(Actor)
  end

  def edit
    set_new_edit(Actor)
  end

  def show
    edit
  end

  def delete
    generic_delete(Actor)
  end

  def process_actor_form(myActor)
    begin
      myActor[:name] = params[controller_path][:name]
      myActor[:remark] = params[controller_path][:remark]
      myActor[:logo] = params[controller_path][:logo]
      myActor.save!
      set_process_notification
    rescue => ex
      index_error(ex)
    end
    redirect_to_index
  end

  def create
    process_actor_form(Actor.new())
  end

  def update
    process_actor_form(Actor.find(params[controller_path][:id]))
  end

end