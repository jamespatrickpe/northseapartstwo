module GenericWizardHelper

  # Render Form Elements
  BASE_LOCATION = 'common_partials/generic_wizard/'

  def render_related_instances(set_name, array_set = nil)
    render(:partial => BASE_LOCATION + 'instances',
           :locals => {:set_name => set_name, :array_set => array_set})
  end

  def setup_wizard_step
    render :template => 'common_partials/generic_form/_main',
           :locals => {:instance => @instance }
  end

  def wizard_activated?
    if (defined?(wizard_path)).nil?
      control = false
    else
      control = true
    end
    control
  end

  def generally_new?
    ( wizard_activated? == true || action_name == 'new' )
  end

  def wizard_final_step(home_controller)
    render :template => 'common_partials/generic_wizard/final_step',
           :locals => {:home_controller => home_controller }
  end

  def related_models(primary_model_type = nil, primary_model_id = nil)
    render :partial => 'common_partials/generic_form/related_models',
           :locals => {:primary_model_type => primary_model_type, :primary_model_id => primary_model_id}
  end


end