class HumanResourcesController < ApplicationController
  include ApplicationHelper

  layout "application_loggedin"

  def index
    render 'human_resources/index'
  end

end