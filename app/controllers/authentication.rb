# **
# Functions with regard to Authentication and Authorization
# **

module Authentication

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

  # Generates Unique Hash for Email Verification
  def create_unique_hash_link
    hash_link = generateRandomString
    if Access.exists?( hash_link: hash_link ) #secures against similar hashlinks; for it to be unique
      hash_link = generateRandomString
    end
    return hash_link
  end

end