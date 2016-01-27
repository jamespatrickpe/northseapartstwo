class AccessController < ApplicationController

  include ApplicationHelper

  layout "application_loggedin",
         only:
             [
                 :dashboard,
                 :'index.html.erb',
                 :my_account
             ]
  skip_before_action :verify_authenticity_token #Need this for AJAX. AJAX Does not work without this.
  before_action :sign_in_check,
                except: [:signin,
                         :processSignin,
                         :registration,
                         :register,
                         :success_registration,
                         :account_recovery,
                         :resend_verification,
                         :resetPassword,
                         :sendRecoveryEmail,
                         :verify,
                         :email_recovery_verification]


  layout "application_loggedin"

  def index
    render 'access/index'
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
    urlRedirect =  "/access/success_registration?email="+params[:access][:email]
      begin
        Actor.transaction do
          # Process Actor
          actor = Actor.new
          actor.name = params[:actor][:name]
          actor.description = params[:actor][:description];
          actor.logo = params[:actor][:logo]
          actor.save!

          # Process Access
          access = Access.new
          access.username = params[:access][:username]
          access.password = params[:access][:password]
          access.password_confirmation = params[:access][:password_confirmation]
          access.email = params[:access][:email]
          access.hash_link = create_unique_hash_link
          access.actor = actor
          access.save!

          # Sends Email
          VerificationMailer.verification_email( params[:access][:email], access.hash_link  ).deliver

          address_set = params[:address]
          telephony_set = params[:telephony]
          digital_set = params[:digital]

          #Address Processing
          address_set.each do |key, value|
            myAddress = Address.new
            myAddress.description = value[:description]
            myAddress.longitude = value[:longitude]
            myAddress.latitude = value[:latitude]
            myAddress.actor = actor
            myAddress.save!
          end

          #Telephony Processing
          telephony_set.each do |key, value|
            myTelephony = Telephone.new
            myTelephony.description = value[:description]
            myTelephony.digits = value[:digits]
            myTelephony.actor = actor
            myTelephony.save!
          end

          #Digital Processing
          digital_set.each do |key, value|
            myDigital = Digital.new
            myDigital.description = value[:description]
            myDigital.url = value[:url]
            myDigital.actor = actor
            myDigital.save!
          end
        end
      rescue StandardError => error
        flash[:general_flash_notification] = "There has been a problem with your submission; Please contact System Administrator." + error.to_s
        urlRedirect = "/access/registration"
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
    flash[:general_flash_notification] = "Verification Error; Account is not Verified"
    verificationCode = params[:hash_link]
    if(Access.exists?( hash_link: verificationCode ) )
      flash[:general_flash_notification] = "Verification Success! Please try signing in."
      myAccess = Access.find_by_hash_link( verificationCode )
      myAccess.verification = 1
      myAccess.save!
    end
    redirect_to action: "signin"
  end

  def resend_verification
    myAccess = Access.find_by_email( params[:email] )
    flash[:general_flash_notification] = "No Account with Email '" + params[:email] + "'"
    if(myAccess)
      VerificationMailer.verification_email( myAccess.email, myAccess.hash_link  ).deliver
      flash[:general_flash_notification] = "Resent Verification Email '" + params[:email] + "'"
    end

    redirect_to "/access/success_registration?email="+params[:email]
  end

  # --------------------------- SIGN IN ------------------------

  def signin
  end

  def processSignin
    reset_session
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
        session[:access_id] = myAccess.id
        myAccess.attempts = 0
        flash[:general_flash_notification] = nil
        currentRedirect = "index"
      else
        myAccess.attempts = myAccess.attempts + 1
      end
      myAccess.save

      redirect_to action: currentRedirect
    rescue => ex
      redirect_to action: currentRedirect
    end
  end

  def signout
    reset_session
    flash[:general_flash_notification] = "You have Successfully Signed Out!"
    redirect_to action: "signin"
  end

  # --------------------------- ACCOUNT RECOVERY ------------------------

  def account_recovery

  end

  def sendRecoveryEmail
    reset_session
    currentRedirect = "/access/account_recovery"
    myAccess = Access.find_by email: params[:email]
    flash[:general_flash_notification] = "No Account with Email '" + params[:email] + "'"
    if(myAccess)
      AccountRecoveryMailer.account_recovery_email( params[:email], myAccess.hash_link ).deliver
      flash[:general_flash_notification] = "Sent Verification Email '" + params[:email] + "'"
      currentRedirect = "/access/email_recovery_verification?email="+params[:email]
    end
    redirect_to currentRedirect
  end

  def email_recovery_verification
    @nextLink = {
        0 => {:url => "../access/sendRecoveryEmail?email="+params[:email], :label => "Resend Verification"},
        1 => {:url => "../home", :label => "Go Back to Home Page"}
    }
    @message = "Request for Account Recovery Initialized. Please access your email to complete verification."
    @title = "Account Recovery Sent"
  end

  def resetPassword
    reset_session
    begin
      myAccess = Access.find_by_hash_link(params[:code])
      myAccess.password = params[:password]
      myAccess.password_confirmation = params[:password_confirmation]
      myAccess.save
      flash[:general_flash_notification] = "Password Change Successful. Please Sign In Again."
    rescue => ex
      flash[:general_flash_notification] = "There was an error in changing your password; no modifications have been made; "
    end
    redirect_to action: "signin"
  end

end