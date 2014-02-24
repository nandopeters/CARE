class RegistrationsController < Devise::RegistrationsController
  before_filter :update_sanitized_params, if: :devise_controller?

  #
  # Start the registration process with the desired :plan
  #
  def new
  	@plan = params[:plan]
  	if @plan && ENV["ROLES"].include?(@plan) && @plan != "admin"
  		super
  	else
  		redirect_to root_path, :notice => "Please select a subscription plan below."
  	end
  end

  #
  # Update the plan based on the type of user, and the desired role
  #
  def update_plan
  	@user = current_user
  	role = Role.find(params[:user][:role_ids]) unless params[:user][:role_ids].nil?
  	if @user.update_plan(role)
  		session[:user_type] = role.name
  		redirect_to edit_user_registration_path, :notice => 'Updated plan.'
  	else
  		flash.alert = 'Unable to update plan.'
  		render :edit
  	end
  end

  #
  # Update the user's credit card, with stripe
  #
  def update_card
  	@user = current_user
  	@user.stripe_token = params[:user][:stripe_token]
  	if @user.save
  		redirect_to edit_user_registration_path, :notice => 'Updated card.'
  	else
  		flash.alert = 'Unable to update card.'
  		render :edit
  	end
  end

  #
  # Redirects the user to the appropriate screen after sign up based on the user's Role
  #   Each user role can have a unique path that is followed after sign up. This is used
  #   for sign up or onboarding wizards, where the user is prompted to add more info
  #
  # @param  resource [User] This is becuase of how Devise handles this method. This is a
  # 	Devise override.
  #
  # @return [route] The route that will be followed
  #
  def after_sign_up_path_for(resource)
  	super if current_user.roles.empty?

  	case current_user.roles.first.name
  	when 'admin'
  		session[:user_type] = 'admin'
  		users_path

  	when 'reg'
  		session[:user_type] = 'reg'
  		reg_home_path

  	when 'VIP'
  		session[:user_type] = 'VIP'
  		vip_home_path

  	else
  		super

  	end
  end


  def update_sanitized_params
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:name, :email, :password, :password_confirmation, :stripe_token, :customer_id, :coupon, :card_number, :card_code, :card_month, :card_year)}
    devise_parameter_sanitizer.for(:account_update) {|u| u.permit(:name, :email, :password, :password_confirmation, :current_password, :stripe_token, :customer_id, :coupon, :card_number, :card_code, :card_month, :card_year)}
  end


private

	#
  # Makes a call to 'super' with no args which executes the :build_resource method of
  #   the class that this class inherits from (Devise::RegistrationsController). After
  #   executing the super class's :build_resource method, the rest of the method code
  #   is executed. It adds the appropriate role to the resource (the User's account type).
	#
	def build_resource(*args)
		super
		if params[:plan]
			resource.add_role(params[:plan])
		end
	end

end
