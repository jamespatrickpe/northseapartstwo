class GeneralAdministration::AddVehiclesWizardController < GeneralAdministrationController

  include Wicked::Wizard

  steps :setup_vehicles,
        :setup_file_sets,
        :setup_image_sets,
        :setup_link_sets,
        :setup_system_associations,
        :final

  def show

    case step
      when :setup_vehicles
        setup_step('Setup Branches',Vehicle)
      when :setup_file_sets
        setup_step('Setup File Sets',FileSet)
      when :setup_image_sets
        setup_step('Setup Image Sets',ImageSet)
      when :setup_link_sets
        setup_step('Setup Link Sets',LinkSet)
      when :setup_system_associations
        setup_step('Setup System Association',SystemAssociation)
      when :final
    end
    render_wizard

  end

  def update

    case step
      when :setup_vehicles
        extracted_id = setup_update_wizard_step(Vehicle)
      when :setup_file_sets
        setup_update_wizard_step(FileSet)
      when :setup_image_sets
        setup_update_wizard_step(ImageSet)
      when :setup_link_sets
        setup_update_wizard_step(LinkSet)
      when :setup_system_associations
        setup_update_wizard_step(SystemAssociation)
      when :final
    end

    redirect_setup_update(params,'Vehicle',extracted_id)

  end

end
