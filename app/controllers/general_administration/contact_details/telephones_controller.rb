class GeneralAdministration::ContactDetails::TelephonesController < GeneralAdministration::ContactDetailsController

  def index
    @telephones = initialize_generic_index(Telephone, [:telephonable])
    render_index
  end

  def search_suggestions
    simple_singular_column_search('telephones.remark',Telephone)
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

  def process_telephone_form(myTelephone)
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
    redirect_to_index
  end

  def create
    process_telephone_form(Telephone.new())
  end

  def update
    process_telephone_form(Telephone.find(params[controller_path][:id]))
  end

end