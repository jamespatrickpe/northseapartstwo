class AccountRecoveryMailer < ApplicationMailer

  default :from => "access@northseaparts.com"
  def account_recovery_email(email, hashlink)
    @hashlink = hashlink
    mail(:to => email, :subject => "Account Recovery Request from the North Sea Parts Information System")
  end

end
