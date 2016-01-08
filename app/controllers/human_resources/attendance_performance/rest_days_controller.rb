class HumanResources::AttendancePerformance::RestDaysController < HumanResources::AttendancePerformanceController

  def index
    query = generic_table_aggregated_queries('rest_days','rest_days.created_at')
    begin
      @rest_days = RestDay
                       .includes(employee: [:actor])
                       .joins(employee: [:actor])
                       .where("actors.name LIKE ? OR " +
                                  "rest_days.id LIKE ? OR " +
                                  "rest_days.day LIKE ? OR " +
                                  "rest_days.created_at LIKE ? OR " +
                                  "rest_days.updated_at LIKE ? ",
                              "%#{query[:search_field]}%",
                              "%#{query[:search_field]}%",
                              "%#{query[:search_field]}%",
                              "%#{query[:search_field]}%",
                              "%#{query[:search_field]}%")
                       .order(query[:order_parameter] + ' ' + query[:order_orientation])
      @rest_days = Kaminari.paginate_array(@rest_days).page(params[:page]).per(query[:current_limit])
    rescue => ex
      flash[:general_flash_notification] = "Error has Occured" + ex.to_s
    end
    render 'human_resources/attendance_performance/rest_days/index'
  end

  def search_suggestions
    restdays = RestDay.includes(employee: :actor).where("actors.name LIKE (?)", "%#{ params[:query] }%").pluck("actors.name")
    direct = "{\"query\": \"Unit\",\"suggestions\":" + restdays.uniq.to_s + "}"
    respond_to do |format|
      format.all { render :text => direct}
    end
  end

  def delete
    restDayToBeDeleted = RestDay.find(params[:rest_day_id])
    restDayOwner = Employee.find(restDayToBeDeleted.employee_id)
    flash[:general_flash_notification_type] = 'Rest day ' + restDayToBeDeleted.day + ' for employees ' + restDayOwner.actor.name + ' has been deleted.'
    flash[:general_flash_notification_type] = 'affirmative'
    restDayToBeDeleted.destroy
    flash[:general_flash_notification] = 'Rest day ' + restDayToBeDeleted.day + ' for employees ' + restDayOwner.actor.name + ' has been deleted.'
    redirect_to :action => 'index'
  end

  def new
    initialize_employee_selection
    @selected_rest_day = RestDay.new
    render 'human_resources/attendance_performance/rest_days/rest_day_form'
  end

  def edit
    initialize_employee_selection
    @selected_rest_day = RestDay.find(params[:id])
    render 'human_resources/attendance_performance/rest_days/rest_day_form'
  end

  def process_rest_day_form(restDay)
    begin
      restDay.id = params[:rest_day][:id]
      restDay.day = params[:rest_day][:day]
      restDay.date_of_effectivity = params[:rest_day][:date_of_effectivity]
      restDay.employee = Employee.find(params[:rest_day][:employee_id])
      restDay.save!
      flash[:general_flash_notification_type] = 'affirmative'
    rescue => ex
      flash[:general_flash_notification] = 'Error Occurred. Please contact Administrator.' + ex.to_s
    end
    redirect_to :action => 'index'
  end

  def create
    rest_day = RestDay.new()
    flash[:general_flash_notification] = 'Rest Day Added!'
    process_rest_day_form(rest_day)
  end

  def update
    rest_day = RestDay.find( params[:rest_day][:id] )
    flash[:general_flash_notification] = 'Rest Day Updated!'
    process_rest_day_form(rest_day)
  end

end
