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
    @selected_actor = Actor.new
    render 'general_administrator/actor/actor_form'
  end

  def edit
    @selected_actor = Actor.find(params[:id])
    render 'general_administrator/actor/actor_form'
  end

  def delete
    actor_to_be_deleted = Actor.find(params[:id])
    flash[:general_flash_notification] = 'System actor ' + actor_to_be_deleted.name + ' has been deleted.'
    flash[:general_flash_notification_type] = 'affirmative'
    actor_to_be_deleted.destroy
    redirect_to :action => "index"
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