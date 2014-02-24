class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end


  # Manages the redirect path after a user signs in
  def after_sign_in_path_for(resource)

    # This tests whether the resque workers are working properly
    # test_resque_workers

    # A case-switch statement that sets the appropriate session info and
    # returns the redirect path appropriate to the user role/type
    case current_user.roles.first.name
    when 'admin'
      session[:user_type] = "admin"
      users_path

    when 'provider'
      session[:user_type] = "provider"
      provider_home_path

    when 'patient'
      session[:user_type] = "patient"
      patient_home_path

    else
      super
    end
  end

  # Overrides the 'root' route when the user is signed in. This is done
  # with a case/switch statement on the user role/type stored in the session
  # hash (stored when the user signs in).
  # @warning This is a potential redirect-loop. That's not good.
  #   The redirect-loop would be in the case of there not being a
  #   session[:user_type], or even if the current_user didn't have a user
  #   type, or had one that wasn't covered by this case statement. Might add
  #   something in the 'else' that doesn't redirect to this same path, or
  #   attempts to check the current_user.roles.first.name instead of the info
  #   stored in the session hash. Later...
  def signed_in_root
    path = case session[:user_type]
    when 'admin'
      users_path

    when 'provider'
      provider_home_path

    when 'patient'
      patient_home_path

    else
      root_path
    end

    path
  end

end
