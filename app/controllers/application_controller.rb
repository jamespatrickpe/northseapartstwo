class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def processErrors(forwardErrorTo)
    #Error Processing
    rescue => e
      flash[:collective_errors] = e
      render "registration"
  end

  def processTemporaryEmail(params)
    #Email Hash Verification
    hashlink = generateRandomString()
    if Verification.exists?( hashlink: hashlink )
      hashlink = generateRandomString()
    else
    end
    flash[:verificationToken] = hashlink

    #Finalization
    VerificationMailer.verification_email( params[:access][:email], hashlink ).deliver
  end

  def rescueAndSendTo(actionToSend)
  #Error Processing
    rescue => e
      flash[:collective_errors] = e
      render actionToSend
  end

  def processRelatedFiles(params)
    @fileSets = params[:related_file]
    @fileSets.each do |key, value|
      @fileSet = FileSet.new( path: value[:path], description: value[:description], rel_file_set: @entity)
      @fileSet.rel_file_set = @entity
      @fileSet.save!
    end
  end

  def processRelatedLinks(params)
    @linkSets = params[:related_link]
    @linkSets.each do |key, value|
      @linkSet = LinkSet.new( url: value[:url], label: value[:label], rel_link_set: @entity)
      @linkSet.rel_link_set = @entity
      @linkSet.save!
    end
  end

  def processSystemAccount(params)
    if(params[:account_option] == "create_new")
      processEntity(params)
      processAccess(params)
      processContactDetails(params)
    elsif(params[:account_option] == "use_existing")
      entityID = params[:assigned_username]
      @access = Access.where(entity_id: entityID)
      @entity = Entity.find(entityID)
    else
      raise("No Option Found")
    end
  end

  def processEntity(params)
    @entity = Entity.new( name: params[:entity][:name], description: params[:entity][:description], logo: params[:entity][:logo])
  end

  def processAccess(params)
    @access = Access.new( username: params[:access][:username], password: params[:access][:password], remember_me: params[:access][:rememberme], password_confirmation: params[:access][:password_confirmation])
    @access.entity = @entity
    @access.save!
  end

  def processContactDetails(params)
    @addressSet = params[:address]
    @telephoneSet = params[:telephony]
    @digitalSet = params[:digital]

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
  end

end
