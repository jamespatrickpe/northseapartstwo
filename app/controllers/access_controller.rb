class AccessController < ApplicationController
  include ApplicationHelper

  layout "application_loggedin", only: [:dashboard]

  def index
    redirect_to :action => "signin"
  end

  def registration

    respond_to do |format|
      format.json { render json: {:"message" => "hello"}.to_json }
      format.html
    end

  end

  def register
    urlRedirect = "";
    ActiveRecord::Base.transaction do
      begin
        processActor(params) #Actor Processing
        processAccess(params) #Access Processing
        processContactDetails(params) #Contact Detail Processing
        processTemporaryEmail(params) #Process Temporary Email
      rescue StandardError => error
        flash[:collective_response] = error
        urlRedirect =  "/access/developer_error"
      end
      urlRedirect =  "/access/success_registration"
    end
    redirect_to urlRedirect
  end

  def success_registration
    access_id = params[:access_id]
    @nextLink = {
        0 => {:url => "../home/verification_delivery?access_id=#{access_id}", :label => "Resend Verification"},
        1 => {:url => "../home", :label => "Go Back to Home Page"}
    }
    @message = "Request for Registration Complete. Please access your email to complete verification. We look forward to working with you!"
    @title = "Registration Successful"
  end

  def verify
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

  def signin
  end

  def registration_complete
  end

  def dashboard
    @accesses = Access.limit(100).offset(0)
  end

  def resend_verification
    AccessMailer.verification_email( params[:access][:email], hashlink, params[:details][:name] ).deliver
    redirect_to action: "success_registration"
  end

end