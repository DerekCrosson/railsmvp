class ApplicationController < ActionController::Base
  #include Concerns::SetCurrentHostForDiskService
  before_action :configure_permitted_parameters, :store_location, if: :devise_controller?
  
  # Store login redirect location and/or role if either exists.
  def store_location
    session[:redirect_url] = params[:redirect_url] if params[:redirect_url]
    session[:role] = params[:role] if params[:role]
  end

  def after_sign_in_path_for(resource_or_scope)
    # If the role param was passed, add the role and remove the default role.
    if session[:role]
      # Add the desired role for the newly registered user.
      current_user.add_role (:client) # TODO: Make this the session role value.
      # This is the default role which is added on registration.
      default_role_name = ENV['default_user_role'].strip(':')[0]
      # Remove the default role for the newly registered user.
      default_role = ActiveRecord::Base.connection.execute("SELECT id from roles where name = #{ default_role_name } LIMIT 1").first
      sqlRemoveDefaultgRole = "DELETE FROM users_roles WHERE user_id = #{ current_user.id } AND role_id = #{ default_role['id'] };"
      ActiveRecord::Base.connection.execute(sqlRemoveDefaultgRole)
      session.delete(:role)
    end
    # Redirect to the desired location or default location after login
    if session[:redirect_url]
      session.delete(:redirect_url)
    else
      super
    end
  end
  
  # Redirect to the desired location or default location after registration
  def after_sign_up_path_for(resource_or_scope)
    if session[:redirect_url]
      session.delete(:redirect_url)
    else
      super
    end
  end
  
  protected

  def configure_permitted_parameters
    # Permit the `firstname and lastname` parameters along with the other
    # Sign up parameters.
    devise_parameter_sanitizer.permit(:sign_up, keys: [:firstname, :lastname])
    # Permit the `redirect_url and role` parameters along with the other
    # Sign in parameters.
    devise_parameter_sanitizer.permit(:sign_in, keys: [:redirect_url, :role])
  end
end
