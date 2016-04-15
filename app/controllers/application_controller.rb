# **
# Application Controller is the base controller for the entire application.
# All shared application-wide functions should be put here.
# **

class ApplicationController < ActionController::Base

  # Must include for AJAX to work
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token

  # Categorized Imports
  include ApplicationHelper,
          GenericForm,
          GenericTable,
          ActorProfile,
          GenericController,
          CommonValidationChecks,
          Authentication,
          StringManipulations,
          GenericShow

end