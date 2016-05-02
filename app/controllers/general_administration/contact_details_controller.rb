class GeneralAdministration::ContactDetailsController < GeneralAdministrationController

  def index
    @contactables = ContactDetail.contactable
  end

end