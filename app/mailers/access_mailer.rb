class AccessMailer < ApplicationMailer

  default :from => "access_control@northseaparts.com"

  def verification_email(email, hashlink, name)
    @email = email
    @hashlink = hashlink
    @name = name
    @url  = 'http://www.northseaparts.com/access/login'
    mail(to: @email, subject: 'Welcome to North Sea Parts')
  end

end