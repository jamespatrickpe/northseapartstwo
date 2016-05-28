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
        controller_instance = SystemActorsController.new
        my_actor = SystemActor.new
        controller_instance.process_form(my_actor, params[controller_path])
        my_actor_id = my_actor.id
      when :setup_address
        my_address = Address.new
        my_address[:longitude] = params[controller_path][:longitude]
        my_address[:latitude] = params[controller_path][:latitude]
        my_address[:remark] = params[controller_path][:remark]
        my_address[:addressable_id] = params[:wizard_primary_model_id]
        my_address[:addressable_type] = wizard_primary_model_type
        my_address.save!
      when :setup_digital
        my_digital = Digital.new
        my_digital[:digitable_id] = params[:wizard_primary_model_id]
        my_digital[:digitable_type] = wizard_primary_model_type
        my_digital[:remark] = params[controller_path][:remark]
        my_digital[:url] = params[controller_path][:url]
        my_digital.save!
      when :setup_telephone
        my_telephone = Telephone.new
        my_telephone[:telephonable_id] = params[:wizard_primary_model_id]
        my_telephone[:telephonable_type] = wizard_primary_model_type
        my_telephone[:digits] = params[controller_path][:digits]
        my_telephone[:remark] = params[controller_path][:remark]
        my_telephone.save!
      when :setup_file_sets
      when :setup_image_sets
      when :setup_link_sets
      when :setup_system_association
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
