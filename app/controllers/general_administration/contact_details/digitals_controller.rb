class GeneralAdministration::ContactDetails::DigitalsController < GeneralAdministration::ContactDetailsController

  def index
    initialize_generic_index(Digital, 'Contact Details in Digital or URL Form')
  end

  def search_suggestions
    generic_index_search_suggestions(Digital)
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

  def process_form(my_digital, current_params, wizard_mode = nil)
    begin
      my_digital[:url] = current_params[:url]
      my_digital[:remark] = current_params[:remark]
      my_digital[:digitable_type] = current_params[:digitable_type]
      my_digital[:digitable_id] = current_params[:digitable_id]
      my_digital.save!
      set_process_notification(current_params) unless wizard_mode
    rescue => ex
      index_error(ex, wizard_mode)
    end
    form_completion_redirect(wizard_mode)
  end

  def create
    process_form(Digital.new(), params[controller_path])
  end

  def update
    process_form(Digital.find(params[controller_path][:id]), params[controller_path])
  end

end