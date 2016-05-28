class GeneralAdministration::AddContactsWizardController < GeneralAdministrationController

  include Wicked::Wizard

  steps :setup_system_actor,
        :setup_address,
        :setup_digital,
        :setup_telephone,
        :setup_file_sets,
        :setup_image_sets,
        :setup_link_sets,
        :setup_system_association,
        :final

  def show

    case step
      when :setup_system_actor
        setup_step('Setup System Actor',SystemActor)
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
      when :setup_system_association
        setup_step('Setup System Association',SystemAssociation)
      when :final
    end
    render_wizard

  end

  def update
    my_actor_id = nil
    wizard_primary_model_type = 'SystemActor'

    case step
      when :setup_system_actor
        my_actor_id = setup_update_wizard_step(SystemActor)
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
      when :setup_system_association
        setup_update_wizard_step(SystemAssociation)
      when :final
    end

    wizard_primary_model_id = (my_actor_id ||= params[:wizard_primary_model_id])

    if params[:add_another] != nil
      redirection_path = wizard_path + "?wizard_primary_model_id=" + wizard_primary_model_id + "&?wizard_primary_model_type=" + wizard_primary_model_type
    else
      redirection_path = next_wizard_path + "?wizard_primary_model_id=" + wizard_primary_model_id + "&?wizard_primary_model_type=" + wizard_primary_model_type
    end
    redirect_to redirection_path
  end

end
