class HumanResources::AttendancePerformance::RegularWorkPeriodsController < HumanResources::AttendancePerformanceController

  def index
    query = generic_table_aggregated_queries('regular_work_periods','regular_work_periods.created_at')
    begin
      @regular_work_periods = RegularWorkPeriod
      .includes(employee: [:actor])
      .joins(employee: [:actor])
      .where("actors.name LIKE ? OR " +
                 "regular_work_periods.id LIKE ? OR " +
                 "regular_work_periods.start_time LIKE ? OR " +
                 "regular_work_periods.end_time LIKE ? OR " +
                 "regular_work_periods.remark LIKE ? OR " +
                 "regular_work_periods.created_at LIKE ? OR " +
                 "regular_work_periods.updated_at LIKE ?",
             "%#{query[:search_field]}%",
             "%#{query[:search_field]}%",
             "%#{query[:search_field]}%",
             "%#{query[:search_field]}%",
             "%#{query[:search_field]}%",
             "%#{query[:search_field]}%",
             "%#{query[:search_field]}%" )
      .order(query[:order_parameter] + ' ' + query[:order_orientation])
      @regular_work_periods = Kaminari.paginate_array(@regular_work_periods).page(params[:page]).per(query[:current_limit])
    rescue
      flash[:general_flash_notification] = "Error has Occured"
    end
    render 'human_resources/attendance_performance/regular_work_periods/index'
  end

  def search_suggestions
    regularWorkPeriods = RegularWorkPeriod.includes(employee: :actor).where("actors.name LIKE (?)", "%#{ params[:query] }%").pluck("actors.name")
    direct = "{\"query\": \"Unit\",\"suggestions\":" + regularWorkPeriods.uniq.to_s + "}"
    respond_to do |format|
      format.all { render :text => direct}
    end
  end

  def delete
    regularWorkPeriodToBeDeleted = RegularWorkPeriod.find(params[:id])
    regularWorkPeriodOwner = Employee.find(regularWorkPeriodToBeDeleted.employee_id)
    flash[:general_flash_notification] = 'Regular work period with Time IN : ' + regularWorkPeriodToBeDeleted.start_time.to_s + ' and Time OUT : ' + regularWorkPeriodToBeDeleted.end_time.to_s + ' for employees ' + regularWorkPeriodOwner.actor.name + ' has been successfully deleted.'
    flash[:general_flash_notification_type] = 'affirmative'
    regularWorkPeriodToBeDeleted.destroy
    redirect_to :action => "index"
  end

  def new
    initialize_employee_selection
    @selected_regular_work_period = RegularWorkPeriod.new
    render 'human_resources/attendance_performance/regular_work_periods/regular_work_period_form'
  end

  def edit
    initialize_employee_selection
    @selected_regular_work_period = RegularWorkPeriod.find(params[:id])
    render 'human_resources/attendance_performance/regular_work_periods/regular_work_period_form'
  end

  def process_regular_work_period_form(regularWorkPeriod)
    begin
      regularWorkPeriod.employee = Employee.find(params[:regular_work_period][:employee_id])
      regularWorkPeriod.start_time = params[:regular_work_period][:start_time]
      regularWorkPeriod.end_time = params[:regular_work_period][:end_time]
      regularWorkPeriod.date_of_effectivity = params[:regular_work_period][:date_of_effectivity]
      regularWorkPeriod.remark = params[:regular_work_period][:remark]
      regularWorkPeriod.save!
      flash[:general_flash_notification_type] = 'affirmative'
    rescue => ex
      puts ex
      flash[:general_flash_notification] = 'Error Occurred. Please contact Administrator.'
    end
    redirect_to :action => 'index'
  end

  def create
    regularWorkPeriod = RegularWorkPeriod.new()
    flash[:general_flash_notification] = 'Regular Work Period Added'
    process_regular_work_period_form(regularWorkPeriod)
  end

  def update
    regularWorkPeriod = RegularWorkPeriod.find(params[:regular_work_period][:id])
    flash[:general_flash_notification] = 'Regular Work Period Updated'
    process_regular_work_period_form(regularWorkPeriod)
  end

end
