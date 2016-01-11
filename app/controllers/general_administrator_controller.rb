class GeneralAdministratorController < ApplicationController
  include ApplicationHelper

  layout "application_loggedin"

  def index
    render 'general_administrator/index'
  end

end
