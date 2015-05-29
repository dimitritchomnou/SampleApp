
#envoi d'email a un user
class UserMailer < ApplicationMailer
	default from: 'notification@examle.com'
	def welcome_email(user)
		@user = user
		email_with_name = %("#{@user.nom}" <#{@user.email}>)
		mail(to: email_with_name, subject: 'Bienvenue sur le site SampleApp')
	end
end

#Envoi multiple de mail par l'Admin
class AdminMailer < ActionMailer::Base
  default to: Proc.new { Admin.pluck(:email) },
          from: 'notification@example.com'
 
  def new_registration(user)
    @user = user
    mail(subject: "New User Signup: #{@user.email}")
  end
end