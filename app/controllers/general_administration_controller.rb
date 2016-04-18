class GeneralAdministrationController < ApplicationController

  layout "application_loggedin"

  def index
    render 'general_administration/index'
  end

end
