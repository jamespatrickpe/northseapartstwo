class AccessController < ApplicationController
  include ApplicationHelper

  layout "application_loggedin", only: [:dashboard]
  skip_before_action :verify_authenticity_token #Need this for AJAX. AJAX Does not work without this.

  #index page
  def index
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


  # --------------------------- REGISTRATION ------------------------

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
        processUserTypeSelection(params)
      rescue StandardError => error
        flash[:collective_response] = error
        urlRedirect =  "/access/developer_error"
      end
      urlRedirect =  "/access/success_registration?email="+params[:access][:email]
    end
    redirect_to urlRedirect
  end

  #Success Registration Page
  def success_registration
    email = params[:email]
    @nextLink = {
        0 => {:url => "../access/resend_verification?email=#{email}", :label => "Resend Verification"},
        1 => {:url => "../access", :label => "Go Back to Home Page"}
    }
    @message = "Request for Registration Complete. Please access your email to complete verification. We look forward to working with you!"
    @title = "Registration Successful"
  end

  def verify
    verificationCode = params[:hashlink]
    myAccess = Access.find_by_hashlink( verificationCode )
    if(myAccess)
      myAccess.verification = 1
      myAccess.save!
    end
    redirect_to action: "signin"
  end

  def resend_verification
    myAccess = Access.find_by_email( params[:email] )
    flash[:general_flash_notification] = "No Account with Email '" + params[:email] + "'"
    if(myAccess)
      VerificationMailer.verification_email( myAccess.email, myAccess.hashlink  ).deliver
      flash[:general_flash_notification] = "Resent Verification Email '" + params[:email] + "'"
    end

    redirect_to "/access/success_registration?email="+params[:email]
  end

  # --------------------------- SIGN IN ------------------------

  def signin
  end

  def processSignin
    flash[:general_flash_notification] = "Invalid Login Details"
    currentRedirect = "signin"

    begin
      myAccess = Access.find_by_username( params[:access][:username_or_email] ) # Find by Username
      if(!myAccess)
        myAccess = Access.find_by_email( params[:access][:username_or_email] ) # Find by Email
      end

      if (myAccess.verification == false)
        flash[:general_flash_notification] = "Your account is not verified; Please check your email"
      end

      if( myAccess.authenticate( params[:access][:password] ) )
        flash[:general_flash_notification] = nil
        currentRedirect = "index"
      else
        myAccess.attempts = myAccess.attempts + 1
        myAccess.save
      end
      redirect_to action: currentRedirect
    rescue => ex
      redirect_to action: currentRedirect
    end

  end

  # --------------------------- ACCOUNT RECOVERY ------------------------

  def account_recovery
  end

  def recoverAccount
    myAccess = Access.find_by email: params[:email]
    flash[:general_flash_notification] = "No Account with Email '" + params[:email] + "'"
    if(myAccess)
      myAccess.send_reset_password_instructions
      flash[:general_flash_notification] = "Resent Verification Email '" + params[:email] + "'"
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