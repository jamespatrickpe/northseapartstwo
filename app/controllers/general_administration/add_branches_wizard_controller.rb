class GeneralAdministration::AddBranchesWizardController < GeneralAdministrationController

  include Wicked::Wizard

  steps :setup_branches,
        :setup_address,
        :setup_digital,
        :setup_telephone,
        :setup_file_sets,
        :setup_image_sets,
        :setup_link_sets,
        :setup_system_associations,
        :final

  def show

    case step
      when :setup_branches
        setup_step('Setup Branches',Branch)
      when :setup_address
        setup_step('Setup Address',Address)
      when :setup_digital
        setup_step('Setup Digital',Digital)
      when :setup_telephone
        setup_step('Setup Telephone',Telephone)
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
      when :setup_branches
        extracted_id = setup_update_wizard_step(Branch)
      when :setup_address
        setup_update_wizard_step(Address)
      when :setup_digital
        setup_update_wizard_step(Digital)
      when :setup_telephone
        setup_update_wizard_step(Telephone)
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

    redirect_setup_update(params,'Branch',extracted_id)


  end

end
