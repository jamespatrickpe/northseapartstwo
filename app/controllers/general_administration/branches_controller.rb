class GeneralAdministration::BranchesController < GeneralAdministrationController

  def index
    initialize_generic_index(Branch, 'Subsidies of North Sea Parts')
  end

  def search_suggestions
    generic_index_search_suggestions(Branch)
  end

  def new
    set_new_edit(Branch)
  end

  def edit
    set_new_edit(Branch)
  end

  def show
    edit
  end

  def delete
    generic_delete(Branch)
  end

  def process_form(my_branch, current_params, wizard_mode = nil)
    begin
      my_branch[:remark] = current_params[:remark]
      my_branch[:name] = current_params[:name]
      my_branch.save!
      set_process_notification
    rescue => ex
      index_error(ex, wizard_mode)
    end
    form_completion_redirect(wizard_mode)
  end

  def create
    process_form(Branch.new(), params[controller_path])
  end

  def update
    process_form(Branch.find(params[controller_path][:id]), params[controller_path])
  end


end