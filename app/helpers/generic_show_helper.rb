module GenericShowHelper

  def render_contact_details()
    render(:partial => 'common_partials/generic_show/contact_details', :locals => {})
  end

  def render_associated_files()
    render(:partial => 'common_partials/generic_show/associated_files', :locals => {})
  end

  def main_show_template
    render(:partial => 'common_partials/generic_show/main_show_template', :locals => {})
  end

end