class GeneralAdministration::ContactDetails::DigitalsController < GeneralAdministration::ContactDetailsController

  def index
    @digitals = initialize_generic_table(Digital)
    render_index
  end

  def search_suggestions
    simple_singular_column_search('digitals.url',Digital)
  end

  def new
    set_new_edit(Digital)
  end

  def edit
    set_new_edit(Digital)
  end

  def show
    edit
  end

  def delete
    generic_delete(Digital)
  end

  def process_digital_form(myDigital)
    begin
      myDigital[:url] = params[controller_path][:url]
      myDigital[:remark] = params[controller_path][:remark]
      myDigital[:digitable_type] = params[controller_path][:digitable_type]
      myDigital[:digitable_id] = params[controller_path][:digitable_id]
      myDigital.save!
      set_process_notification
    rescue => ex
      index_error(ex)
    end
    redirect_to_index
  end

  def create
    process_digital_form(Digital.new())
  end

  def update
    process_digital_form(Digital.find(params[controller_path][:id]))
  end

end