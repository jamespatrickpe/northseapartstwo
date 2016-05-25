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
        setup_step('Setup Address',Address)
      when :setup_digital
        setup_step('Setup Digital',Digital)
      when :setup_telephone
        setup_step('Setup Telephone',Telephone)
      when :final_contacts
    end
    render_wizard

  end

  def update
    case step
      when :setup_system_actor
        selected_model_instance = SystemActor.new
        selected_model_instance[:name] = params[controller_path][:name]
        selected_model_instance[:logo] = params[controller_path][:logo]
        selected_model_instance[:remark] = params[controller_path][:remark]
      when :setup_address
      when :setup_digital
      when :setup_telephone
      when :final_contacts
    end
    selected_model_instance.save
    redirect_to next_wizard_path + 'polymorphic_id?=' + params[:model_id] + 'polymorphic_type?=' + params[:model_id]
  end

end
