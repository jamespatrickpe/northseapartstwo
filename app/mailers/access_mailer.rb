# class AccessMailer < ApplicationMailer
#
#   default :from => "northseaparts@gmail.com"
#
#   def verification_email(email, hashlink, name)
#     @email = email
#     @hashlink = hashlink
#     @name = name
#     @url  = 'http://www.northseaparts.com/access/login'
#     mail(to: @email, subject: 'Welcome to North Sea Parts')
#   end
#
# end

class AccessMailer < Devise::Mailer
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  default template_path: 'devise/mailer' # to make sure that your mailer uses the devise views



end