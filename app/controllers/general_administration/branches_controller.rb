class GeneralAdministration::BranchesController < GeneralAdministrationController

  def index
    query = generic_table_aggregated_queries('branches','branches.created_at')
    begin
      @branches = Branch
                      .where("branches.name LIKE ? OR " +
                                 "branches.id LIKE ?",
                             "%#{query[:search_field]}%",
                             "%#{query[:search_field]}%")
                      .order(query[:order_parameter] + ' ' + query[:order_orientation])
      @branches = Kaminari.paginate_array(@branches).page(params[:page]).per(query[:current_limit])
    rescue => ex
      flash[:general_flash_notification] = "Error has Occured" + ex.to_s
    end
    render '/general_administration/branches/index'
  end


  def initialize_form()
    initialize_form_variables('BRANCH',
                              'general_administration/branches/branch_form',
                              'branches'
    )
  end

  def search_suggestions
    branches = Branch
                   .where("branches.name LIKE ?","%#{params[:query]}%")
                   .pluck("branches.name")
    direct = "{\"query\": \"Unit\",\"suggestions\":[" + branches.to_s.gsub!('[', '').gsub!(']', '') + "]}"
    respond_to do |format|
      format.all { render :text => direct}
    end
  end

  def new
    initialize_form
    @selected_branch = Branch.new
    @actors = Actor.all().order('name ASC')
    @branches = Branch.all().order('name ASC')
    generic_single_column_form(@selected_branch)
  end

  def edit
    initialize_form
    @selected_branch = Branch.find(params[:id])
    @actors = Actor.all().order('name ASC')
    @branches = Branch.all().order('name ASC')
    generic_single_column_form(@selected_branch)
  end

  def show
    initialize_form
    @form_location = 'general_administration/branches/show'
    @selected_branch = Branch.find(params[:id])
    get_contact_details(Branch, @selected_branch)
    get_associated_files(Branch, @selected_branch)
    generic_model_show(@selected_branch, Branch.all() , 'name')
  end

  def delete
    generic_delete_model(Branch,controller_name)
  end

  def process_branch_form(myBranch)
    begin
      myBranch[:name] = params[:branch][:name]
      myBranch.save!
      flash[:general_flash_notification_type] = 'affirmative'
    rescue => ex
      flash[:general_flash_notification] = 'Error Occurred. Please contact Administrator.' + ex.to_s
    end
    redirect_to :action => 'index'
  end

  def create
    myBranch = Branch.new()
    flash[:general_flash_notification] = 'Branch Created!'
    process_branch_form(myBranch)
  end

  def update
    myBranch = Branch.find(params[:branch][:id])
    flash[:general_flash_notification] = 'Branch Updated: ' + params[:branch][:id]
    process_branch_form(myBranch)
  end

end