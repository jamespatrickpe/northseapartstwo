class GeneralAdministrator::BranchController < GeneralAdministratorController


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
    render '/general_administrator/branch/index'
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
    @selected_branch = Branch.new
    render 'general_administrator/branch/branch_form'
  end

  def edit
    @selected_branch = Branch.find(params[:id])
    render 'general_administrator/branch/branch_form'
  end

  def delete
    branch_to_be_deleted = Branch.find(params[:id])
    flash[:general_flash_notification] = 'Branch ' + branch_to_be_deleted.name + ' has been deleted from database'
    flash[:general_flash_notification_type] = 'affirmative'
    branch_to_be_deleted.destroy
    redirect_to :action => 'index'
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