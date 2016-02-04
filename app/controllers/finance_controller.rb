class FinanceController < ApplicationController

  include ApplicationHelper

  layout "application_loggedin"

  def index
    render 'finance/index'
  end

end
