module GenericShow

  def generic_model_show(model, model_selections, display_attribute_for_option)
    render :template => 'common_partials/generic_show/_main_show_template',
           :locals => {:model => model,
                       :model_selections => model_selections,
                       :display_attribute_for_option => display_attribute_for_option
           }
  end

  def get_contact_details(model_type, selected_model)
    @selected_address_set = get_address_set(model_type, selected_model)
    @selected_telephone_set = get_telephone_set(model_type, selected_model)
    @selected_digital_set = get_digital_set(model_type, selected_model)
  end

  def get_address_set(model_type, selected_model)
    model_type = model_type.to_s
    Address.where("addressable_id = ? AND addressable_type = ?", "#{selected_model.id}", "#{model_type}")
  end

  def get_telephone_set(model_type, selected_model)
    model_type = model_type.to_s
    Telephone.where("telephonable_id = ? AND telephonable_type = ?", "#{selected_model.id}", "#{model_type}")
  end

  def get_digital_set(model_type, selected_model)
    model_type = model_type.to_s
    Digital.where("digitable_id = ? AND digitable_type = ?", "#{selected_model.id}", "#{model_type}")
  end

  def get_associated_files(model_type, selected_model)
    @selected_file_set = get_file_set(model_type, selected_model)
    @selected_image_set = get_image_set(model_type, selected_model)
    @selected_link_set = get_link_set(model_type, selected_model)
  end

  def get_file_set(model_type, selected_model)
    model_type = model_type.to_s
    FileSet.where("filesetable_id = ? AND filesetable_type = ?", "#{selected_model.id}", "#{model_type}")
  end

  def get_image_set(model_type, selected_model)
    model_type = model_type.to_s
    ImageSet.where("imagesetable_id = ? AND imagesetable_type = ?", "#{selected_model.id}", "#{model_type}")
  end

  def get_link_set(model_type, selected_model)
    model_type = model_type.to_s
    LinkSet.where("linksetable_id = ? AND linksetable_type = ?", "#{selected_model.id}", "#{model_type}")
  end

end