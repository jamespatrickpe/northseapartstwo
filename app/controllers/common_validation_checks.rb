# **
# Validation Checks for Forms throughout entire Controller
# **

module CommonValidationChecks

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

end