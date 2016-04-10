# **
# Application Controller is the base controller for the entire application.
# All shared application-wide functions should be put here.
# **

class ApplicationController < ActionController::Base

  # Must include for AJAX to work
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token

  # Make Controller Functions also available as a Helper Method
  helper_method :error_messages_for, :shift_table_orientation, :insertTimeIntoDate

  # Categorized Imports
  include ApplicationHelper,
          GenericForm,
          GenericTable,
          ActorProfile,
          GenericController,
          StringManipulations

  def check_unique_holiday_date
    date_of_implementation_exists = Holiday.exists?(date_of_implementation: params[:holiday][:date_of_implementation])
    respond_to do |format|
      format.json { render json: {:"exists" => date_of_implementation_exists}.to_json }
    end
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

  def check_leave_date_if_overlap
    employee_id = params[:employee_id]

    x = Time.at(params[:start_of_effectivity].to_f / 1000)
    y = Time.at(params[:end_of_effectivity].to_f / 1000)

    rangeOfLeaves =  Leave.where("(employee_id = ?) AND start_of_effectivity between ? AND ?", "#{employee_id}", "#{x}", "#{y}")
    existingLeaves =  Leave.where("employee_id = ?", "#{employee_id}").order(start_of_effectivity: :asc)

    val = false

    # Check if dates are overlapping using 'cover?'
    existingLeaves.each do |l|

      if (x..y).cover?(l.start_of_effectivity..l.end_of_effectivity) then
        val = true
        break
      end

    end

    respond_to do |format|
      format.all { render :text => val}
    end
  end


  def create_unique_hash_link
    # Generates Unique Hash for Email Verification
    hash_link = generateRandomString
    if Access.exists?( hash_link: hash_link ) #secures against similar hashlinks; for it to be unique
      hash_link = generateRandomString
    end
    return hash_link
  end



  def employee_overview_profile
    respond_to do |format|
      employee_overview_profile = Employee.find(params[:employee_ID]).to_json({ :include => :actor })
      format.all { render :json => employee_overview_profile}
    end
  end

  def employee_overview_duty_status
    currentEmployee = Employee.includes(:duty_status).joins(:duty_status).where("(employees.id = ?)", "#{params[:employee_ID]}").order('duty_statuses.date_of_effectivity DESC').first
    if currentEmployee.duty_status.first.active == true
      sample = 'ACTIVE'
    else
      sample = 'INACTIVE'
    end
    respond_to do |format|
      format.all { render :text => sample}
    end
  end

  # Regular Sign In Check
  def sign_in_check
    if( Access.exists?( session[:access_id]) )
      @myAccess = Access.find(session[:access_id])
      @myActor = @myAccess.actor
      @myAccess.last_login = Time.now
      @myAccess.save!
      @sign_in_affirmative = true
    else
      flash[:general_flash_notification] = "Invalid Login Credentials"
      redirect_to "/access/signin"
    end
  end

  def check_employee_name_exists
    employee_name = params[:employee_select_field]
    result = Employee.includes(:actor).joins(:actor).where("actors.name = ?","#{employee_name}").exists?
    respond_to do |format|
      format.json { render json: {:"exists" => result}.to_json }
      format.html
    end
  end

  def check_username_exists
    username_exists = Access.exists?(username: params[:access][:username])
    respond_to do |format|
      format.json { render json: {:"exists" => username_exists}.to_json }
      format.html
    end
  end

  def check_email_exists
    email_exists = Access.exists?(email: params[:access][:email])
    respond_to do |format|
      format.json { render json: {:"exists" => email_exists}.to_json }
      format.html
    end
  end

  def processConstants
    flash[:notice] = "Save Successful!"
    currentController = params[:controller]
    constantSet = params[:settings]
    constantSet.each do |key, value|
      temp_constant = Constant.find_by(name: key)
      temp_constant.update(constant: value)
    end
    redirect_to "/"+currentController+"/settings"
  end

  def processRelatedFiles(params)
    @fileSets = params[:related_file]
    @fileSets.each do |key, value|
      @fileSet = FileSet.new( path: value[:path], description: value[:description], rel_file_set: @actor)
      @fileSet.rel_file_set = @actor
      @fileSet.save!
    end
  end

  def processRelatedLinks(params)
    @linkSets = params[:related_link]
    @linkSets.each do |key, value|
      @linkSet = LinkSet.new( url: value[:url], label: value[:label], rel_link_set: @actor)
      @linkSet.rel_link_set = @actor
      @linkSet.save!
    end
  end

  def processSystemAccount(params)
    if(params[:account_option] == "create_new")
      processActor(params)
      processAccess(params)
      processContactDetails(params)
    elsif(params[:account_option] == "use_existing")
      actorID = params[:assigned_username]
      @access = Access.where(actor_id: actorID)
      @actor = Actor.find(actorID)
    else
      raise("No Option Found")
    end
  end

end
