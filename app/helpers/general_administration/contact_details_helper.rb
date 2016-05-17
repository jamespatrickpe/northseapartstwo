module GeneralAdministration::ContactDetailsHelper

  def controller_link(result)
    controller_link = nil
    if result.class == Telephone
      controller_link = general_administration_contact_details_telephones_path
    elsif result.class == Address
      controller_link = general_administration_contact_details_addresses_path
    elsif result.class == Digital
      controller_link = general_administration_contact_details_digitals_path
    end
    controller_link
  end

end
