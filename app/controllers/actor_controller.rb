class ActorController < ApplicationController
  include ApplicationHelper

  layout "application_loggedin"

  def index
    query = generic_table_aggregated_queries('actors','actors.created_at')
    begin
      @actors = Actor
                      .where("actors.id LIKE ? OR " +
                                 "actors.name LIKE ? OR " +
                                 "actors.description LIKE ? ",
                             "%#{query[:search_field]}%",
                             "%#{query[:search_field]}%",
                             "%#{query[:search_field]}%")
                      .order(query[:order_parameter] + ' ' + query[:order_orientation])
      @actors = Kaminari.paginate_array(@actors).page(params[:page]).per(query[:current_limit])

    rescue => ex
      puts ex
      flash[:general_flash_notification] = "Error has Occured"
    end
    render '/general_administrator/actor_search/index'
  end

end