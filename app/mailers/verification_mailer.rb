class VerificationMailer < ApplicationMailer

  default :from => "accesscontrol@northseaparts.com"
  def verification_email(email, hashlink)
    @hashlink = hashlink
    mail(:to => email, :subject => "Verification Request from the North Sea Parts Information System")
  end

end
