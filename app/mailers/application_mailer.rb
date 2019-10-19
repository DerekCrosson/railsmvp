class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
  
  def registration_email(user)
    @user = user
    mail(:to => user.email, :subject => "Welcome to App Name!!!")
  end
end
