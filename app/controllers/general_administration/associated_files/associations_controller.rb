class GeneralAdministration::AssociatedFiles::AssociaitionsController < GeneralAdministration::AssociatedFilesController

  def index
    @associations = initialize_generic_table(Association)
  end

  def search_suggestions
    simple_singular_column_search('associations.remark',Association)
  end

  def new
    set_new_edit(Association)
  end

  def edit
    set_new_edit(Association)
  end

  def show
    edit
  end

  def delete
    generic_delete(Association)
  end

  def process_file_form(association)
    begin
      association[:remark] = params[controller_path][:remark]
      association[:model_one_type] = params[controller_path][:model_one_type]
      association[:model_one_id] = params[controller_path][:model_one_id]
      association[:model_two_type] = params[controller_path][:model_two_type]
      association[:model_two_id] = params[controller_path][:model_two_id]
      association.save!
      set_process_notification
    rescue => ex
      index_error(ex)
    end
    redirect_to_index
  end

  def create
    process_file_form(Association.new())
  end

  def update
    process_file_form(Association.find(params[controller_path][:id]))
  end

end
