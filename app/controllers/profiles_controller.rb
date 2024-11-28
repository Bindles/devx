class ProfilesController < ApplicationController
  before_action :set_user_and_profile, only: [:show, :edit, :update]

  def update
    ActiveRecord::Base.transaction do
      # Handle avatar upload if present
      if profile_params[:avatar_url].present?
        uploaded_file = profile_params[:avatar_url]
        uploaded_url = upload_to_imgbb(uploaded_file)

        if uploaded_url
          @profile.avatar_url = uploaded_url
        else
          raise ActiveRecord::Rollback, "Image upload failed"
        end
      end

      # Update the user and profile
      if @user.update(user_params) && @profile.update(profile_params.except(:avatar_url))
        redirect_to user_profile_path(@user), notice: 'Profile was successfully updated.'
      else
        raise ActiveRecord::Rollback
      end
    end

    render :edit if @user.errors.any? || @profile.errors.any?
  end

  private

  def set_user_and_profile
    @user = User.find(params[:user_id])
    @profile = @user.profile
  end

  def user_params
    params.require(:user).permit(:username)
  end

  def profile_params
    params.require(:user).require(:profile).permit(:bio, :avatar_url)
  end

  def upload_to_imgbb(file)
    response = HTTParty.post(
      "https://api.imgbb.com/1/upload",
      body: {
        key: '4f66fe834812539df61c11f438b7e147', # Your API key
        image: Base64.encode64(file.read)
      }
    )

    if response.code == 200
      response.dig("data", "url") # Return the image URL
    else
      Rails.logger.error("ImgBB upload failed: #{response.dig('error', 'message')}")
      nil
    end
  end
end
