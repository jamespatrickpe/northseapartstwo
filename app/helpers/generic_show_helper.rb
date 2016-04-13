module GenericShowHelper

  def render_contact_details()
    render(:partial => "common_partials/show_panels/contact_details", :locals => {})
  end

  def render_associated_files()
    render(:partial => "common_partials/show_panels/associated_files", :locals => {})
  end

end