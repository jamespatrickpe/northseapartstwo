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

  def process_form(branch)
    begin
      branch[:remark] = params[controller_path][:remark]
      branch[:name] = params[controller_path][:name]
      branch.save!
      set_process_notification
    rescue => ex
      index_error(ex)
    end
    form_completion_redirect
  end

  def create
    process_form(Branch.new())
  end

  def update
    process_form(Branch.find(params[controller_path][:id]))
  end


end