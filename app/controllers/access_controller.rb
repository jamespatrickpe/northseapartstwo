class AccessController < ApplicationController
  include ApplicationHelper

  layout "application_loggedin", only: [:dashboard]
  skip_before_action :verify_authenticity_token #Need this for AJAX. AJAX Does not work without this.
  before_action :authenticate_access!, only: [ :my_account ]

  #index page

  def index
    redirect_to :action => "signin"
  end

  def dashboard
    @accesses = Access.limit(100).offset(0)
  end

  # --------------------------- ACCOUNT SETTINGS ------------------------

  #Personal Account Settings
  def my_account
  end

  def account_settings
    #current locations
    #language settings
    #dsecription change
    #profile picture change
    render "account_settings/index"
  end


  # --------------------------- REGISTRATION PROCESS ------------------------

  #Registration Form
  def registration
  end

  #Process the Registration Form
  def register
    urlRedirect = "";
    ActiveRecord::Base.transaction do
      begin
        processActor(params)
        processAccess(params)
        processContactDetails(params)
        processTemporaryEmail(params)
        processUserTypeSelection(params)
      rescue StandardError => error
        flash[:collective_response] = error
        urlRedirect =  "/access/developer_error"
      end
      urlRedirect =  "/access/success_registration"
    end
    redirect_to urlRedirect
  end

  #Success Registration Page
  def success_registration
    access_id = params[:access_id]
    @nextLink = {
        0 => {:url => "../access/verification_delivery?access_id=#{access_id}", :label => "Resend Verification"},
        1 => {:url => "../access", :label => "Go Back to Home Page"}
    }
    @message = "Request for Registration Complete. Please access your email to complete verification. We look forward to working with you!"
    @title = "Registration Successful"
  end

  def verify(params)
    verificationCode = params[:code]
    verification = Verification.where( hashlink: verificationCode ).first
    currentAccess = Access.where( id: verification.access_id).first
    #currentAccess = Verification.access
    verification.verified = 1
    currentAccess.enabled = 1
    verification.save
    currentAccess.save
  
    flash[:verification] = currentAccess.id
    flash[:notice] = "Congratulations! Your account has been verified. Depending on your arrangement with the administrator; certain features may not yet be available; but you may now login!"
    redirect_to action: "signin"
  end

  def resend_verification
    AccessMailer.verification_email( params[:access][:email], hashlink, params[:details][:name] ).deliver
    redirect_to action: "success_registration"
  end

  def registration_complete
  end

  def verification_delivery
    @access_id = params[:access_id]
    verification = Verification.find_by(access_id: @access_id)
    @currentEmail = verification.temp_email
    render "shared/verification_delivery"
  end

  def resend_verification
    access_id = params[:access_id]
    email = params[:access][:email]
    verification = Verification.find_by(access_id: access_id)
    verification.update(temp_email: email)
    VerificationMailer.verification_email( email, verification.hashlink ).deliver
    flash[:notice] = "Reverification Email has been sent!"
    redirect_to action: "verification_delivery", access_id: access_id
  end

  # --------------------------- SIGN IN PROCESS ------------------------

  def signin
  end

  # --------------------------- ACCOUNT RECOVERY PROCESS ------------------------

  def account_recovery
  end

  def recoverAccount
    myAccess = Access.find_by email: params[:email]
    if(myAccess)
      myAccess.send_reset_password_instructions
    end
    redirect_to action: "email_recovery_verification", email: params[:email]
  end

  def email_recovery_verification
    @nextLink = {
        0 => {:url => "../access/recoverAccount?email="+params[:email], :label => "Resend Verification"},
        1 => {:url => "../home", :label => "Go Back to Home Page"}
    }
    @message = "Request for Account Recovery Initialized. Please access your email to complete verification."
    @title = "Account Recovery Sent"
  end

end