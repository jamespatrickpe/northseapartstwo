class GeneralAdministration::ContactDetailsController < GeneralAdministrationController

  def index
    @contact_details = initialize_generic_table(ContactDetail)
  end

  def search_suggestions
    simple_singular_column_search('contact_details.remark',ContactDetail)
  end

  def new
    set_new_edit(ContactDetail)
  end

  def edit
    set_new_edit(ContactDetail)
  end

  def show
    edit
  end

  def delete
    generic_delete(ContactDetail)
  end

  def process_contact_detail_form(myContactDetail)
    begin
=begin
      myContactDetail[:url] = params[controller_path][:url]
      myContactDetail[:remark] = params[controller_path][:remark]
      myDigital[:digitable_type] = params[controller_path][:digitable_type]
      myDigital[:digitable_id] = params[controller_path][:digitable_id]
      myDigital.save!
=end
      set_process_notification
    rescue => ex
      index_error(ex)
    end
    redirect_to_index
  end

  def create
    process_contact_detail_form(ContactDetail.new())
  end

  def update
    process_contact_detail_form(ContactDetail.find(params[controller_path][:id]))
  end

end