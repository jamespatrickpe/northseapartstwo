class GeneralAdministratorController < ApplicationController
  include ApplicationHelper

  layout "application_loggedin"

  # ================== Branches ================== #

  def branches
    order_parameter = ActiveRecord::Base.sanitize(aggregated_search_queries(params[:order_parameter], 'branches', "order_parameter" ,"created_at")).gsub("'", '')
    order_orientation = ActiveRecord::Base.sanitize(aggregated_search_queries(params[:order_orientation], 'branches',"order_orientation", "DESC")).gsub("'", '')
    current_limit = ActiveRecord::Base.sanitize(aggregated_search_queries(params[:current_limit], 'branches',"current_limit","10")).gsub("'", '')
    search_field = ActiveRecord::Base.sanitize(aggregated_search_queries(params[:search_field], 'branches',"search_field","")).gsub("'", '')

    begin
      @branches = Branch
                      .where("branches.name LIKE ? OR branches.id LIKE ?", "%#{search_field}%","%#{search_field}%" )
                      .order(order_parameter + ' ' + order_orientation)
      @branches = Kaminari.paginate_array(@branches).page(params[:page]).per(current_limit)
    rescue => ex
      puts ex
      flash[:general_flash_notification] = "Error has Occured"
    end

    #Render
    # render 'human_resources/employee_accounts_management/index'
    render '/general_administrator/branches'
  end

  def search_suggestions_branches
    branches = Branch.where("branches.name LIKE (?)", "%#{ params[:query] }%").pluck("branches.name")
    direct = "{\"query\": \"Unit\",\"suggestions\":" + branches.to_s + "}"
    respond_to do |format|
      format.all { render :text => direct}
    end
  end

  def new_branch
    initialize_employee_selection
    @selected_branch = Branch.new
    render '/general_administrator/branch_form'
  end

  def edit_branch
    initialize_employee_selection
    @selected_branch = Branch.find(params[:branch_id])
    render '/general_administrator/branch_form'
  end

  def delete_branch
    branchToBeDeleted = Branch.find(params[:branch_id])
    flash[:general_flash_notification_type] = 'Branch ' + branchToBeDeleted.name + ' has been successfully deleted.'
    flash[:general_flash_notification_type] = 'affirmative'
    branchToBeDeleted.destroy
    redirect_to :action => "branches"
  end

  def process_branch_form
    begin
      if( params[:branch][:id].present? )
        branch = Branch.find(params[:branch][:id])
      else
        branch = Branch.new()
      end
      branch.id = params[:branch][:id]
      branch.name = params[:branch][:name]
      branch.save!
      flash[:general_flash_notification] = 'Branch ' + branch.name + ' has been added.'
      flash[:general_flash_notification_type] = 'affirmative'
    rescue => ex
      puts ex
      flash[:general_flash_notification] = 'Error Occurred. Please contact Administrator.'
    end
    redirect_to :action => 'branches'
  end

end
