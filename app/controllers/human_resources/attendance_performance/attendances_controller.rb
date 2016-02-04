class HumanResources::AttendancePerformance::AttendancesController < HumanResources::AttendancePerformanceController

  def index
    query = generic_table_aggregated_queries('attendances','attendances.created_at')
    begin
      @attendances = ::Attendance
                         .includes(employee: [:actor])
                         .joins(employee: [:actor])
                         .where("actors.name LIKE ? OR " +
                                    "attendances.id LIKE ? OR " +
                                    "attendances.timein LIKE ? OR " +
                                    "attendances.timeout LIKE ? OR " +
                                    "attendances.remark LIKE ? OR " +
                                    "attendances.updated_at LIKE ? OR " +
                                    "attendances.created_at LIKE ?",
                                "%#{query[:search_field]}%",
                                "%#{query[:search_field]}%",
                                "%#{query[:search_field]}%",
                                "%#{query[:search_field]}%",
                                "%#{query[:search_field]}%",
                                "%#{query[:search_field]}%",
                                "%#{query[:search_field]}%")
                         .order(query[:order_parameter] + ' ' + query[:order_orientation])
      @attendances = Kaminari.paginate_array(@attendances).page(params[:page]).per(query[:current_limit])
    rescue => ex
      flash[:general_flash_notification] = "Error has Occured" + ex.to_s
      @sample = ex.to_s
    end
    render 'human_resources/attendance_performance/attendances/index'
  end

  def delete
    attendaceToBeDeleted = ::Attendance.find(params[:id])
    attendanceOwner = Employee.find(attendaceToBeDeleted.employee_id)
    flash[:general_flash_notification] = 'Attendance for ' + attendanceOwner.actor.name + ' has been deleted.'
    flash[:general_flash_notification_type] = 'affirmative'
    attendaceToBeDeleted.destroy
    redirect_to :action => 'index'
  end

  def new
    initialize_employee_selection
    @selected_attendance = ::Attendance.new
    render 'human_resources/attendance_performance/attendances/attendance_form'
  end

  def edit
    initialize_employee_selection
    @selected_attendance = ::Attendance.find(params[:id])
    render 'human_resources/attendance_performance/attendances/attendance_form'
  end

  def process_attendance_form(myAttendance)
    begin
      myAttendance.employee_id = params[:attendance][:employee_id]
      myAttendance.date_of_attendance = params[:attendance][:date_of_attendance]
      myAttendance.timein = params[:attendance][:timein]
      myAttendance.timeout = params[:attendance][:timeout]
      myAttendance.remark = params[:attendance][:remark]
      myAttendance.save!
      flash[:general_flash_notification_type] = 'affirmative'
    rescue => ex
      flash[:general_flash_notification] = 'Error Occurred. Please contact Administrator.'
    end
    redirect_to :action => 'index'
  end

  def search_suggestions
    generic_employee_name_search_suggestions(Attendance)
  end
  def create
    myAttendance = ::Attendance.new
    flash[:general_flash_notification] = 'Attendance Added!'
    process_attendance_form(myAttendance)
  end

  def update
    myAttendance = ::Attendance.find(params[:attendance][:id])
    flash[:general_flash_notification] = 'Attendance Updated!'
    process_attendance_form(myAttendance)
  end

end
