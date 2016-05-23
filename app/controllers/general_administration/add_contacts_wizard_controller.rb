class GeneralAdministration::AddContactsWizardController < GeneralAdministrationController

  include Wicked::Wizard

  steps :setup_actor, :setup_address, :setup_digital, :setup_telephone

  def show



    @title = 'Add Contacts Wizard'
    case step
      when :setup_actor
        @subtitle = 'Add Actor'
        @selected_model_instance = SystemActor.new()
        @path = @selected_model_instance.main_representation[:controller_path]
      when :setup_address
        @subtitle = 'Add Address'
        @selected_model_instance = Address.new()
        @path = @selected_model_instance.main_representation[:controller_path]
      when :setup_digital
      when :setup_telephone
    end

    render_wizard

  end

end
