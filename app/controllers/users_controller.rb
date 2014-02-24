class UsersController < ApplicationController
  before_filter :authenticate_user!

  #
  # List all the users. This is for the Admin
  #
  def index
    authorize! :index, @user, :message => 'Not authorized as an administrator.'
    @users = User.all
  end

  #
  # Show a user's page (profile page more or less) based on the requested user :id. This
  #   page will show their contact info, specialties, location, and nearby providers
  #
  def show
    @user = User.find(params[:id])
  end

  #
  # Update a given user's role. This can only be done as the Admin.
  #
  def update
    authorize! :update, @user, :message => 'Not authorized as an administrator.'
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  #
  # Destroy a given user. This can only be done as the Admin.
  #
  def destroy
    authorize! :destroy, @user, :message => 'Not authorized as an administrator.'
    user = User.find(params[:id])
    unless user == current_user
      user.destroy
      redirect_to users_path, :notice => "User deleted."
    else
      redirect_to users_path, :notice => "Can't delete yourself."
    end
  end

private

  def user_params
    params.require(:user).permit!
  end
end