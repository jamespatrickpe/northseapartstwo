class HumanResources::CompensationAndBenefits::LeavesController < HumanResources::CompensationAndBenefitsController

  def index
    query = generic_table_aggregated_queries('leaves','leaves.created_at')
    begin
      @leaves = Leave.all
      @leaves = Kaminari.paginate_array(@leaves).page(params[:page]).per(query[:current_limit])
    rescue => ex
      flash[:general_flash_notification] = "Error has Occured" + ex.to_s
      @sample = ex.to_s
    end
    render 'human_resources/compensation_and_benefits/leaves/index'
  end

  def delete
    leaveToBeDeleted = Leave.find(params[:id])
    leaveOwner = Employee.find(leaveToBeDeleted.employee_id)
    flash[:general_flash_notification] = 'Leave for ' + leaveOwner.actor.name + ' has been deleted.'
    flash[:general_flash_notification_type] = 'affirmative'
    leaveToBeDeleted.destroy
    redirect_to :action => 'index'
  end

  def new
    initialize_employee_selection
    @selected_leave = Leave.new
    @selected_leave.start_of_effectivity = Time.now
    @selected_leave.end_of_effectivity = Time.now
    render 'human_resources/compensation_and_benefits/leaves/leave_form'
  end

  def edit
    initialize_employee_selection
    @selected_leave = Leave.find(params[:id])
    render 'human_resources/compensation_and_benefits/leaves/leave_form'
  end

  def search_suggestions
    generic_employee_name_search_suggestions(Leave)
  end

  def process_leave_form(myLeave)
    begin
      myLeave.employee_id = params[:leave][:employee_id]
      myLeave.start_of_effectivity = params[:leave][:start_of_effectivity]
      myLeave.end_of_effectivity = params[:leave][:end_of_effectivity]
      myLeave.type_of_leave = params[:leave][:type_of_leave]
      myLeave.remark = params[:leave][:remark]
      myLeave.save!
      flash[:general_flash_notification_type] = 'affirmative'
    rescue => ex
      puts ex
      flash[:general_flash_notification] = 'Error Occurred. Please contact Administrator.'
    end
    redirect_to :action => 'index'
  end

  def create
    myLeave = Leave.new
    flash[:general_flash_notification] = 'Leave Added!'
    process_leave_form(myLeave)
  end

  def update
    myLeave = Leave.find(params[:leave][:id])
    flash[:general_flash_notification] = 'Leave Updated!'
    process_leave_form(myLeave)
  end

end
