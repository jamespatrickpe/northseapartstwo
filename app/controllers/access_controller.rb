class AccessController < ApplicationController
  include ApplicationHelper

  def index
    redirect_to :action => "signin"
  end

  def registration
  end

  def register

    @addressSet = params[:address]
    @telephoneSet = params[:telephony]
    @digitalSet = params[:digital]

    ActiveRecord::Base.transaction do
      begin
        #Entity Processing
        @entity = Entity.new( name: params[:details][:name], description: params[:details][:description], logo: params[:details][:logo])

        #Access Processing
        @access = Access.new( username: params[:access][:username], password: params[:access][:password], remember_me: params[:access][:rememberme], security_level: 'NONE', password_confirmation: params[:access][:password_confirmation])
        @access.entity = @entity
        @access.save!

        #Contact Detail Processing
        @contactDetail = ContactDetail.new()
        @contactDetail.entity = @entity
        @contactDetail.save!

        @verification = Verification.new( temp_email: params[:access][:email], verified: false, hashlink: generateRandomString().downcase )
        @verification.access = @access
        @verification.save!

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

        #Email Hash Verification
        hashlink = generateRandomString()
        if Verification.exists?( hashlink: hashlink )
          hashlink = generateRandomString()
        else
        end
        flash[:verificationToken] = hashlink

        #Finalization
        VerificationMailer.verification_email( params[:access][:email], hashlink ).deliver
        redirect_to action: "verification"

      #Error Processing
      rescue => e
        flash[:active_record_errors] = e
        render "registration"
      end

    end
  end

  def verification
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

  def verify_again
    AccessMailer.verification_email( params[:access][:email], hashlink, params[:details][:name] ).deliver
    redirect_to action: "verification"
  end

end