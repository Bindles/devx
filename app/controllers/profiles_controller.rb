class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def show
    @profile = @user.profile
  end

  def edit
    @profile = @user.profile
  end

  def update
    @profile = @user.profile
    if @profile.update(profile_params)
      redirect_to user_profile_path(@user), notice: "Profile updated successfully!"
    else
      flash[:alert] = "Failed to update profile."
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def profile_params
    params.require(:profile).permit(:bio, :avatar_url)
  end
end
