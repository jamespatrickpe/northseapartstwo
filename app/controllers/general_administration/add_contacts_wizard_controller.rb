class GeneralAdministration::AddContactsWizardController < GeneralAdministrationController

  include Wicked::Wizard

  steps :setup_system_actor,
        :setup_address,
        :setup_digital,
        :setup_telephone,
        :final_contacts

  def show

    case step
      when :setup_system_actor
        setup_step('Setup System Actor',SystemActor)
      when :setup_address

        myActor[:name] = params[controller_path][:name]
        myActor[:remark] = params[controller_path][:remark]
        myActor.logo = params[controller_path][:logo]

        setup_step('Setup Address',Address)
      when :setup_digital
        setup_step('Setup Digital',Digital)
      when :setup_telephone
        setup_step('Setup Telephone',Telephone)
      when :final_contacts
    end
    render_wizard

  end

end
