class GeneralAdministrationController < ApplicationController

  layout "application_loggedin"

  def index
    @overview_panels = [
        [general_administration_associated_files_path,'Associated Files'],
        [general_administration_branches_path,'Branches'],
        [general_administration_contact_details_path,'Contact Details'],
        [general_administration_system_actors_path,'System Actors'],
        [general_administration_vehicles_path,'Vehicles']
    ]

    @wizard_buttons =
    [
        [general_administration_add_contacts_wizard_path(:setup_system_actor),'Add Contacts Wizard'],
        [general_administration_import_contacts_wizard_path(:introduction_to_import),'Import Contacts Wizard'],
        [general_administration_add_branches_wizard_path(:setup_branches),'Add Branches Wizard'],
        [general_administration_add_vehicles_wizard_path(:setup_vehicles),'Add Vehicles Wizard']
    ]  

    generic_index_main('System-Wide General Administration Concerns')
  end



end
