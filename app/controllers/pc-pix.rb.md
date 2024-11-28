class ProfilesController < ApplicationController
  before_action :set_user_and_profile, only: [:show, :edit, :update]

  def update
    ActiveRecord::Base.transaction do
      # Update the user
      if @user.update(user_params)
        # Handle avatar upload
        if profile_params[:avatar_file].present?
          uploaded_image_url = upload_to_imgbb(profile_params[:avatar_file])
          @profile.avatar_url = uploaded_image_url if uploaded_image_url
        end
  
        # Update the profile
        if @profile.update(profile_params.except(:avatar_file))
          redirect_to user_profile_path(@user), notice: 'Profile was successfully updated.'
        else
          raise ActiveRecord::Rollback
        end
      else
        raise ActiveRecord::Rollback
      end
    end
  
    render :edit if @user.errors.any? || @profile.errors.any?
  end
  
  private
  
  def upload_to_imgbb(file)
    require 'httparty'
  
    response = HTTParty.post("https://api.imgbb.com/1/upload", body: {
      key: '4f66fe834812539df61c11f438b7e147', # Replace with your API key
      image: Base64.encode64(file.read),
      name: "#{@user.username}-avatar"
    })
  
    if response.code == 200
      response.parsed_response["data"]["url"]
    else
      nil # Log error in production
    end
  end

  def set_user_and_profile
    @user = User.find(params[:user_id])
    @profile = @user.profile
  end

  def user_params
    params.require(:user).permit(:username)  # Only permit username for user
  end

  def profile_params
    params.require(:user).require(:profile).permit(:bio, :avatar_url)  # Ensure profile attributes are permitted correctly
  end
end
