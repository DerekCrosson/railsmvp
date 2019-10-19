class SendRegistrationEmailJob < ActiveJob::Base
  queue_as :default

  def perform(user)
    @user = user
    ApplicationMailer.registration_email(user).deliver_later
  end
end