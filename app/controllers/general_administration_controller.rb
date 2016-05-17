class GeneralAdministrationController < ApplicationController

  layout "application_loggedin"

  def index
    @overview_panels = [
        [general_administration_actors_path,'Actors'],
        [general_administration_associated_files_path,'Associated Files'],
        [general_administration_branches_path,'Branches'],
        [general_administration_contact_details_path,'Contact Details'],
        [general_administration_vehicles_path,'Vehicles']
    ]
    generic_index_main('System Wide Administrative Concerns')
  end



end
