
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout "application_loggedin"
  skip_before_action :verify_authenticity_token #Need this for AJAX. AJAX Does not work without this.
  helper_method :error_messages_for, :shift_table_orientation

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
      @sign_in_affirmative = true
    else
      flash[:general_flash_notification] = "Invalid Login Credentials"
      redirect_to "/access/signin"
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

  def processActor(params)
    #@actor = Actor.new( name: params[:actor][:name], description: params[:actor][:description], logo: params[:actor][:logo])
    @actor = Actor.new
    @actor.name = params[:actor][:name];
    @actor.description = params[:actor][:description];
    @actor.logo = params[:actor][:logo]
    @actor.save!
  end

  def processAccess(params)

    #Generates Unique Hash for Email Verification
    hashlink = generateRandomString()
    if Access.exists?( hashlink: hashlink ) #secures against similar hashlinks; for it to be unique
      hashlink = generateRandomString()
    else
    end

    @access = Access.new
    @access.username = params[:access][:username]
    @access.password = params[:access][:password]
    @access.password_confirmation = params[:access][:password_confirmation]
    @access.email = params[:access][:email]
    @access.hashlink = hashlink
    @access.actor = @actor
    @access.save

    VerificationMailer.verification_email( params[:access][:email], @access.hashlink  ).deliver
  end

  def processContactDetails(params)
    @addressSet = params[:address]
    @telephoneSet = params[:telephony]
    @digitalSet = params[:digital]

    #Contact Detail Processing
    @contactDetail = ContactDetail.new()
    @contactDetail.actor = @actor
    @contactDetail.save!

    #Address Processing
    @addressSet.each do |key, value|
      @address = Address.new( description: value[:description], longitude: value[:longitude], latitude: value[:latitude] )
      @address.contact_detail = @contactDetail
      @address.save!
    end

    #Telephony Processing
    @telephoneSet.each do |key, value|
      @telephony = Telephone.new( description: value[:description], digits: value[:digits] )
      @telephony.contact_detail = @contactDetail
      @telephony.save!
    end

    #Digital Processing
    @digitalSet.each do |key, value|
      @digital = Digital.new( description: value[:description], url: value[:url] )
      @digital.contact_detail = @contactDetail
      @digital.save!
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
