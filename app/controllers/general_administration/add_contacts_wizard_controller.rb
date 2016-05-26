class GeneralAdministration::AddContactsWizardController < GeneralAdministrationController

  include Wicked::Wizard

  steps :setup_system_actor,
        :setup_address,
        :setup_digital,
        :setup_telephone,
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
      when :final
    end
    render_wizard

  end

  def update
    my_actor_id = nil
    case step
      when :setup_system_actor
        myActor = SystemActor.new
        myActor[:name] = params[controller_path][:name]
        myActor[:logo] = params[controller_path][:logo]
        myActor[:remark] = params[controller_path][:remark]
        myActor.save
        my_actor_id = myActor.id
      when :setup_address
        myAddress = Address.new
        myAddress[:longitude] = params[controller_path][:longitude]
        myAddress[:latitude] = params[controller_path][:latitude]
        myAddress[:remark] = params[controller_path][:remark]
        myAddress[:addressable_id] = params[:wizard_primary_model_id]
        myAddress[:addressable_type] = 'SystemActor'
        myAddress.save
      when :setup_digital
        myDigital = Digital.new
        myDigital[:digitable_id] = params[:wizard_primary_model_id]
        myDigital[:digitable_type] = 'SystemActor'
        myDigital[:remark] = params[controller_path][:remark]
        myDigital[:url] = params[controller_path][:url]
      when :setup_telephone
        myTelephone = Telephone.new
        myTelephone[:telephonable_id] = params[:wizard_primary_model_id]
        myTelephone[:telephonable_type] = 'SystemActor'
        myTelephone[:digits] = params[controller_path][:digits]
        myTelephone[:remark] = params[controller_path][:remark]
      when :final

    end

    wizard_primary_model_id = (my_actor_id ||= params[:wizard_primary_model_id])
    redirect_to next_wizard_path + "?wizard_primary_model_id='" + wizard_primary_model_id + "'"
  end

end
