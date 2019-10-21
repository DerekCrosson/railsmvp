class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :confirmable, :database_authenticatable, :lockable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  def assign_default_role
    # Assign the default user role after the user is created.
    add_role(ENV['default_user_role']) if self.roles.blank?
  end
  
  def set_username
    # Generate a unique username before creating the user.
    self.username = "#{self.email[/^[^@]+/]}-#{SecureRandom.hex(1)}"
  end
  
  def send_registration_mail
    # Use a delayed job to send the registration email.
    SendRegistrationEmailJob.set(wait: 20.seconds).perform_later(self)
  end
end
