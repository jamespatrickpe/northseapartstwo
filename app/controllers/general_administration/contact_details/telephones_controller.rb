class GeneralAdministration::ContactDetails::TelephonesController < GeneralAdministration::ContactDetailsController

  def index
    initialize_generic_index(Telephone, 'Contact Details through Telephony')
  end

  def search_suggestions
    generic_index_search_suggestions(Telephone)
  end

  def new
    set_new_edit(Telephone)
  end

  def edit
    set_new_edit(Telephone)
  end

  def show
    edit
  end

  def delete
    generic_delete(Telephone)
  end

  def process_form(myTelephone)
    begin
      myTelephone[:digits] = params[controller_path][:digits]
      myTelephone[:remark] = params[controller_path][:remark]
      myTelephone[:telephonable_type] = params[controller_path][:telephonable_type]
      myTelephone[:telephonable_id] = params[controller_path][:telephonable_id]
      myTelephone.save!
      set_process_notification
    rescue => ex
      index_error(ex)
    end
    form_completion_redirect
  end

  def create
    process_form(Telephone.new())
  end

  def update
    process_form(Telephone.find(params[controller_path][:id]))
  end

end