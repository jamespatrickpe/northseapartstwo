
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout "application_loggedin"
  skip_before_action :verify_authenticity_token #Need this for AJAX. AJAX Does not work without this.
  helper_method :error_messages_for, :shift_table_orientation

  def initialize_actor_selection
    @employees = Employee.includes(:actor).joins(:actor)
  end

  def actor_profile
    if( params[:actor_id] )
      @selected_actor = Actor.find(params[:actor_id])
      @selected_access = Access.find_by_actor_id(@selected_actor.id)
      @selected_biodata = Biodatum.find_by_actor_id(@selected_actor.id)
      @selected_address_set = Address.where("actor_id = ?", "#{@selected_actor.id}")
      @selected_telephone_set = Telephone.where("actor_id = ?", "#{@selected_actor.id}")
      @selected_digital_set = Digital.where("actor_id = ?", "#{@selected_actor.id}")
      @selected_file_set = FileSet.where("rel_file_set_id = ? AND rel_file_set_type = 'Actor'", "#{@selected_actor.id}")
      @selected_image_set = ImageSet.where("rel_image_set_id = ? AND rel_image_set_type = 'Actor'", "#{@selected_actor.id}").order('priority DESC')
    end
    @selected_actor ||= Actor.new
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

  def constants
    currentController = params[:controller]
    @constants = Constant.where('name LIKE ?', "%"+currentController+"%")
    render "shared/constants"
  end

  def processConstants
    flash[:notice] = "Save Successful!"
    currentController = params[:controller]
    constantSet = params[:constants]
    constantSet.each do |key, value|
      temp_constant = Constant.find_by(name: key)
      temp_constant.update(constant: value)
    end
    redirect_to "/"+currentController+"/constants"
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
      if(role == "employee")

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
