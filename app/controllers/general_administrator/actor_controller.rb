class GeneralAdministrator::ActorController < GeneralAdministratorController

  def index
    query = generic_table_aggregated_queries('actors','actors.created_at')
    begin
      @actors = Actor
                    .where("actors.name LIKE ? OR " +
                               "actors.id LIKE ? OR " +
                               "actors.description LIKE ? ",
                           "%#{query[:search_field]}%",
                           "%#{query[:search_field]}%",
                           "%#{query[:search_field]}%")
                    .order(query[:order_parameter] + ' ' + query[:order_orientation])
      @actors = Kaminari.paginate_array(@actors).page(params[:page]).per(query[:current_limit])

    rescue => ex
      flash[:general_flash_notification] = "Error has Occured"
    end
    render '/general_administrator/actor/index'
  end

  def initialize_form
    initialize_form_variables('ACTOR',
                              'general_administrator/actor/actor_form',
                              'actor')
    initialize_employee_selection
  end

  def search_suggestions
    actors = Actor
                 .where("actors.name LIKE ?","%#{params[:query]}%")
                 .pluck( "actors.name")
    direct = "{\"query\": \"Unit\",\"suggestions\":[" + actors.to_s.gsub!('[', '').gsub!(']', '') + "]}"
    respond_to do |format|
      format.all { render :text => direct}
    end
  end

  def new
    initialize_form
    @selected_actor = Actor.new
    generic_singlecolumn_form(@selected_actor)
  end

  def edit
    initialize_form
    @selected_actor = Actor.find(params[:id])
    generic_singlecolumn_form(@selected_actor)
  end

  def show
    initialize_form
  end

  def delete
    generic_delete_model(Actor,controller_name)
  end

  def process_actor_form(myActor)
    begin
      myActor[:name] = params[:actor][:name]
      myActor[:description] = params[:actor][:description]
      myActor[:logo] = params[:actor][:logo]
      myActor.save!
      flash[:general_flash_notification_type] = 'affirmative'
    rescue => ex
      flash[:general_flash_notification] = 'Error Occurred. Please contact Administrator.' + ex.to_s
    end
    redirect_to :action => 'index'
  end

  def create
    myActor = Actor.new()
    flash[:general_flash_notification] = 'Actor was successfully created!'
    process_actor_form(myActor)
  end

  def update
    myActor = Actor.find(params[:actor][:id])
    flash[:general_flash_notification] = 'Actor Updated: ' + params[:actor][:id]
    process_actor_form(myActor)
  end

end