class GeneralAdministratorController < ApplicationController

  layout "application_loggedin"

  def index
    render 'general_administrator/index'
  end

end
