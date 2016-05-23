class GeneralAdministration::ContactsWizardController < GeneralAdministrationController

  include Wicked::Wizard

  steps :setup_actor, :setup_address, :setup_digital, :setup_telephone

  def show
    @subtitle = 'Setup Actors'
    case step
      when :setup_actor
        @selected_model_instance = SystemActor.new()
      when :setup_address
      when :setup_digital
      when :setup_telephone
    end
    render_wizard
  end



end
