class VerificationMailer < ApplicationMailer

  default :from => "accesscontrol@northseaparts.com"
  def verification_email(email, hashlink)
    @hashlink = hashlink
    @url = "http://www.northseaparts.com/signin"
    mail(:to => email, :subject => "Welcome to North Sea Parts!")
  end

end
