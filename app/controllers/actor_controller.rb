class GeneralAdministrator::ActorController < GeneralAdministratorController

  include ApplicationHelper

  layout "application_loggedin"

  def index
    query = generic_table_aggregated_queries('actors','actors.created_at')
    @initialQuery = query[:search_field]

    if query[:search_field].empty?
      # Initial page load, do nothing and show nothing (default search enginer behavior, no search query, no resultset on view)
    else
      # Process flow will enter here upon initial search
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

    end

    render '/general_administrator/actor/index'
  end

  def search_suggestions
    actors = Actor
                 .where("actors.name LIKE ?","%#{params[:query]}%")
                 .pluck("actors.name")
    direct = "{\"query\": \"Unit\",\"suggestions\":[" + actors.to_s.gsub!('[', '').gsub!(']', '') + "]}"
    respond_to do |format|
      format.all { render :text => direct}
    end
  end

  def actor

  end

  def new

  end


end