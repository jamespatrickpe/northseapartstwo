module GenericShow

  def generic_model_show(model, model_selections, display_attribute_for_option)
    render :template => 'common_partials/generic_show/_main_show_template',
           :locals => {:model => model,
                       :model_selections => model_selections,
                       :display_attribute_for_option => display_attribute_for_option
           }
  end

end