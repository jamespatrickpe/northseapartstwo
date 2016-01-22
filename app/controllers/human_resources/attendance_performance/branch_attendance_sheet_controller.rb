class HumanResources::AttendancePerformance::BranchAttendanceSheetController < HumanResources::AttendancePerformanceController

  def index
    @branches = Branch.all
    begin
      if params[:branch].present? && params[:start_date].present? && params[:end_date].present?
        @start_date = DateTime.strptime(params[:start_date],"%Y-%m-%d")
        @end_date = DateTime.strptime(params[:end_date],"%Y-%m-%d")
        @number_of_days = (@end_date - @start_date).abs.to_i + 1
        @selected_branch = Branch.find(params[:branch][:id])
        @employees_by_branch = Employee
                                   .includes(:actor, :duty_status)
                                   .joins(:actor, :duty_status)
                                   .where("branch_id = ?", "#{@selected_branch.id}")
        @attendances_per_employee_in_branch = ::Attendance.includes(:employee).joins(:employee).where("employees.branch_id = ?", "#{@selected_branch.id}")
      end
      @selected_branch ||= Branch.new
    rescue => ex
      flash[:general_flash_notification] = "Error has Occurred" + ex.to_s
    end
    render 'human_resources/attendance_performance/branch_attendance_sheet/index'
  end

  def process_branch_attendance_sheet
    branch_id = params[:branch][:id]
    start_date = params[:start_date]
    end_date = params[:end_date]
    flash[:general_flash_notification] = 'Attendance (if any) has been recorded.'
    flash[:general_flash_notification_type] = 'Affirmative'
    ::Attendance.transaction do
      begin
        total_items = params[:total_items].to_i
        total_items.times do |i|
          if params[:attendance_performance][i.to_s][:timein].present? || params[:attendance_performance][i.to_s][:timeout].present?
            myAttendance = ::Attendance.new
            myDate = Date.strptime(params[:attendance_performance][i.to_s][:date],"%F")
            if params[:attendance_performance][i.to_s][:timein].present?
              myTimeIn = Time.parse(params[:attendance_performance][i.to_s][:timein], myDate)
              timein = DateTime.new( myDate.year, myDate.month, myDate.day, myTimeIn.hour, myTimeIn.min, myTimeIn.sec, "+8")
              myAttendance.timein = timein
            end
            if params[:attendance_performance][i.to_s][:timeout].present?
              myTimeOut = Time.parse(params[:attendance_performance][i.to_s][:timeout], myDate)
              timeout = DateTime.new( myDate.year, myDate.month, myDate.day, myTimeOut.hour, myTimeOut.min, myTimeOut.sec, "+8" )
              myAttendance.timeout = timeout
            end
            similar_attendances = ::Attendance.where("(employee_id = ?) AND (date_of_attendance = ?)", "#{params[:attendance_performance][i.to_s][:employee_id]}", "#{myDate.strftime("%Y-%m-%d")}")
            similar_attendances.each do | similar_attendance |
              similar_attendance_timein = insertTimeIntoDate(myDate, similar_attendance[:timein])
              similar_attendance_timeout = insertTimeIntoDate(myDate, similar_attendance[:timeout])
              actor_name = params[:attendance_performance][i.to_s][:employee_actor_name]
              date_conflict = myDate.month.to_s + '/' + myDate.day.to_s + '/' + myDate.year.to_s
              if timein.between?(similar_attendance_timein, similar_attendance_timeout) || timeout.between?(similar_attendance_timein, similar_attendance_timeout)
                raise 'No Attendance has been recorded; Time Conflict for ' + actor_name +  ' on the date of ' + date_conflict
              elsif (timein..timeout).overlaps?(similar_attendance_timein..similar_attendance_timeout)
                raise 'No Attendance has been recorded; Overlap Conflict for ' + actor_name +  ' on the date of ' + date_conflict
              elsif timein.to_i > timeout.to_i
                raise 'No Attendance has been recorded; Time In is more than Time Out for ' + actor_name +  ' on the date of ' + date_conflict
              else
              end
            end
            myAttendance.date_of_attendance = myDate
            myAttendance.employee_id = params[:attendance_performance][i.to_s][:employee_id]
            myAttendance.remark = params[:attendance_performance][i.to_s][:remark]
            myAttendance.save!
          end
        end
      rescue => ex
        ex.message.present? ? flash[:general_flash_notification] = ex.message : flash[:general_flash_notification] = 'Error has Occurred; Please Contact Administrator'
      end
    end
    redirect_to :action => 'index', :branch => {:id => branch_id}, :start_date => start_date, :end_date => end_date
  end


end
