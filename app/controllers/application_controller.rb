
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token #Need this for AJAX. AJAX Does not work without this.
  helper_method :error_messages_for, :shift_table_orientation, :insertTimeIntoDate
  include ApplicationHelper

  def initialize_form_variables(title, subtitle, form_location, singular_model_name)
    @title = title
    @subtitle = subtitle
    @form_location = form_location
    @singular_model_name = singular_model_name
  end

  def generic_bicolumn_form_with_employee_selection(model)
    render :template => 'shared/generic_bicolumn_form_with_employee_selection', :locals => {:model => model}
  end

  def generic_singlecolumn_form(model)
    render :template => 'shared/generic_singlecolumn_form', :locals => {:model => model}
  end

  def generic_delete_model(model, my_controller_name)
    model_to_be_deleted = model.find(params[:id])
    flash[:general_flash_notification] = model_to_be_deleted.id + " has been successfully deleted "
    flash[:general_flash_notification_type] = 'affirmative'
    model_to_be_deleted.destroy
    redirect_to :controller => my_controller_name, :action => 'index'
  end

  def generic_employee_name_search_suggestions(model)
    my_model = model.includes(employee: :actor).where("actors.name LIKE (?)", "%#{ params[:query] }%").pluck("actors.name")
    direct = "{\"query\": \"Unit\",\"suggestions\":" + my_model.uniq.to_s + "}" # default format for plugin
    respond_to do |format|
      format.all { render :text => direct}
    end
  end

  def initialize_actor_selection
    @employees = Employee.includes(:actor).joins(:actor)
  end

  def actor_profile
    if( params[:actor_id] )
      @selected_actor = Actor.find(params[:actor_id])
      @selected_access = Access.find_by_actor_id(@selected_actor.id)
      @selected_biodata = Biodatum.find_by_actor_id(@selected_actor.id)
      @selected_address_set = Address.where("rel_model_id = ?", "#{@selected_actor.id}")
      @selected_telephone_set = Telephone.where("rel_model_id = ?", "#{@selected_actor.id}")
      @selected_digital_set = Digital.where("rel_model_id = ?", "#{@selected_actor.id}")
      @selected_file_set = FileSet.where("rel_file_set_id = ? AND rel_file_set_type = 'Actor'", "#{@selected_actor.id}")
      @selected_image_set = ImageSet.where("rel_image_set_id = ? AND rel_image_set_type = 'Actor'", "#{@selected_actor.id}").order('priority DESC')
    end
    @selected_actor ||= Actor.new
  end

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

  def initialize_employee_selection
    @employees = Employee.includes(:actor).joins(:actor)
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

  #Reset Search Common Paremeters
  def reset_search
    flash.clear
    flash[:general_flash_notification] = 'Search Queries Cleared'
    flash[:general_flash_notification_type] = 'affirmative'
    redirect_to params[:reset_search_redirect]
  end

  # Stores previous search queries for aggregated results
  def aggregated_search_queries(value, table_id, key, default)
    if value
      actual_query_parameter = value
    elsif flash[table_id + '_' + key]
      actual_query_parameter = flash[table_id + '_' + key]
    else
      actual_query_parameter = default
    end
    flash[table_id + '_' + key] = actual_query_parameter
    return actual_query_parameter
  end

  def generic_table_aggregated_queries( mysql_table_name, mysql_created_at, my_order = 'DESC', my_limit = '10')
    order_parameter = aggregated_search_queries(params[:order_parameter], mysql_table_name, 'order_parameter' , mysql_created_at)
    order_orientation = aggregated_search_queries(params[:order_orientation], mysql_table_name, 'order_orientation', my_order)
    current_limit = aggregated_search_queries(params[:current_limit], mysql_table_name, 'current_limit', my_limit)
    search_field = aggregated_search_queries(params[:search_field], mysql_table_name, 'search_field','')
    return {:order_parameter => order_parameter, :order_orientation => order_orientation, :current_limit => current_limit, :search_field => search_field}
  end

  # Shifts the ASC/DESC on the header of table
  def shift_table_orientation
    table_orientation = Hash.new()
    table_orientation["order_orientation"] = ""
    table_orientation["orientation_symbol"] = ""
    if( params[:order_orientation] == "ASC" )
      table_orientation["order_orientation"] = "DESC"
      table_orientation["orientation_symbol"] = '&#x25BC;'
    else
      table_orientation["order_orientation"] = "ASC"
      table_orientation["orientation_symbol"] = '&#x25B2;'
    end
    return table_orientation
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

  def getEmployees
    @employees = Employee.all
    @employee_id = params[:employee_id]
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

  def processUserTypeSelection(params)
    @roles = params[:access][:role]
    @roles.each do |role|
      if(role == "employees")

      end
    end
  end

  def generateStorageLabels(params)
    branchCode = params[:storage][:branchCode]
    branchCode = params[:storage][:branchCode]
    branchCode = params[:storage][:branchCode]
  end

  def trimString(string)
    return string.strip!
  end

  def error_messages_for(object)
    render(:partial => "core_partials/formerrors", :locals => {:object => object})
  end
end
