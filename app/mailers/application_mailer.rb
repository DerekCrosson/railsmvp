class ApplicationMailer < ActionMailer::Base
  default from: ENV['smtp_user_name']
  layout 'mailer'
  
  def registration_email(user)
    @user = user
    mail(:to => user.email, :subject => "Welcome to App Name!!!")
  end
end
