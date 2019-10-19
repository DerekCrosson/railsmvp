Rails.application.routes.draw do
  namespace :v1 do
    namespace :resources do
      namespace :users do
        get ':username' => :show
        patch ':username' => :update
        put ':username' => :update
        delete ':username' => :delete
        get 'all'
        post 'new'
      end
    end
  end
  devise_for :users
  devise_scope :user do
    root to: "devise/registrations#new" # Make the registration page the app root URL
  end
  # If you are running this app as an API only, this can be removed.
  get "/#{Rails.application.config.google_verification}.html",
  to: proc { |env| [200, {},
    ["google-site-verification:
    #{Rails.application.config.google_verification}.html"]] }
end
