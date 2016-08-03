# **guide
# Form Helpers render different types of Fields in Forms
# **

module GenericFormHelper

  BASE_LOCATION = 'common_partials/generic_form/'

  def render_money_field(base_form, instance, attribute_name)
    render( partial: BASE_LOCATION + 'money_field',
            locals: { base_form: base_form, instance: instance, attribute_name: attribute_name })
  end

  def render_collection_selector(base_form, instance, attribute_name, my_label, my_collection, label_method = nil, value_method = nil)
    render( partial: BASE_LOCATION + 'collection_selector',
            locals: { base_form: base_form,
                      instance:  instance,
                      attribute_name: attribute_name,
                      my_label: my_label,
                      my_collection: my_collection,
                      label_method: label_method,
                      value_method: value_method })
  end

  def render_employee_selector(base_form, instance)
    render( partial: BASE_LOCATION + 'employee_selector',
            locals: { base_form: base_form, instance: instance })
  end

  def render_datetime_field(base_form, instance, attribute_name, my_label)
    render( partial: BASE_LOCATION + 'datetime_field',
            locals: { base_form: base_form,
                      instance: instance,
                      attribute_name: attribute_name,
                      my_label: my_label })
  end

  def render_form_footer(base_form, instance_id)
    render( partial: BASE_LOCATION + 'footer', locals: { base_form: base_form, instance_id: instance_id })
  end

  def render_remark_field(base_form, instance)
    render( partial: BASE_LOCATION + 'remark_field',
            locals: { base_form: base_form, instance: instance })
  end

  def render_polymorphic_selector(base_form, instance, polymorphic_attribute)
    render( partial: BASE_LOCATION + 'polymorphic_selector',
            locals: { base_form: base_form,
                      instance: instance,
                      polymorphic_attribute: polymorphic_attribute })
  end

  def render_field_measurement(base_form, instance, name, current_label, default_unit, required = false)
    render( partial: BASE_LOCATION + 'field_measurement',
            locals: { base_form: base_form,
                      instance: instance,
                      name: name,
                      current_label: current_label,
                      default_unit: default_unit,
                      required: required })
  end

end