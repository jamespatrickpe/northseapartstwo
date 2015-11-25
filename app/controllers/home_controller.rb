class HomeController < ApplicationController

  layout 'application'

  def verification_delivery
    @access_id = params[:access_id]
    verification = Verification.find_by(access_id: @access_id)
    @currentEmail = verification.temp_email
    render "shared/verification_delivery"
  end

  def testing

    puts "Jc Gofredoz"

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

  def index
  end

  def parts_library
  end


  def become_a_supplier
  end

  def become_a_retailer
  end

  def store_locations
  end

  def about_us
  end

  def developer_error
  end

  def actor_error
  end

end
