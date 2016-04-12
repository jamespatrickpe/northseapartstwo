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

  def initialize_form
    initialize_form_variables('ATTENDANCE',
                              'human_resources/attendance_performance/attendances/attendance_form',
                              'attendance')
    initialize_employee_selection
  end

  def delete
    generic_delete_model(Attendance,controller_name)
  end

  def new
    initialize_form
    @selected_attendance = ::Attendance.new
    generic_bicolumn_form_with_employee_selection(@selected_attendance)
  end

  def edit
    initialize_form
    @selected_attendance = ::Attendance.find(params[:id])
    generic_bicolumn_form_with_employee_selection(@selected_attendance)

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

  def check_time_if_between_attendance
    time_check = false
    my_time = Time.strptime(params[:time],"%H:%M")
    employee_id = params[:employee_id]
    my_date = Date.strptime(params[:date],"%F")
    current_time = DateTime.new(my_date.year, my_date.month, my_date.day, my_time.hour, my_time.min, my_time.sec, "+8" )
    similar_attendances = Attendance.where("(employee_id = ?) AND (date_of_attendance = ?)", "#{employee_id}", "#{my_date}")
    similar_attendances.each do | similar_attendance |
      similar_attendance_timein = insertTimeIntoDate(my_date, similar_attendance[:timein])
      similar_attendance_timeout = insertTimeIntoDate(my_date, similar_attendance[:timeout])
      if current_time.between?(similar_attendance_timein, similar_attendance_timeout)
        time_check = true
      end
    end
    respond_to do |format|
      format.all { render :text => time_check}
    end
  end

  def check_time_if_overlap_attendance
    time_check = false
    timein = Time.strptime(params[:timein],"%H:%M")
    timeout = Time.strptime(params[:timeout],"%H:%M")
    my_date = Date.strptime(params[:date],"%F")
    employee_id = params[:employee_id]
    current_time_in = DateTime.new(my_date.year, my_date.month, my_date.day, timein.hour, timein.min, timein.sec, "+8" )
    current_time_out = DateTime.new(my_date.year, my_date.month, my_date.day, timeout.hour, timeout.min, timeout.sec, "+8" )
    similar_attendances = Attendance.where("(employee_id = ?) AND (date_of_attendance = ?)", "#{employee_id}", "#{my_date}")
    similar_attendances.each do | similar_attendance |
      similar_attendance_timein = insertTimeIntoDate(my_date, similar_attendance[:timein])
      similar_attendance_timeout = insertTimeIntoDate(my_date, similar_attendance[:timeout])
      if (current_time_in..current_time_out).overlaps?(similar_attendance_timein..similar_attendance_timeout)
        time_check = true
      end
    end
    respond_to do |format|
      format.all { render :text => time_check}
    end
  end

end
