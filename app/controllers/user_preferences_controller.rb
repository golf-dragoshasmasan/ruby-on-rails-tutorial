class UserPreferencesController < ApplicationController
  before_action :correct_user

  # GET /users/:user_id/preferences
  def show
    if @user.preference
      render json: @user.preference, status: :ok
    else
      render json: { error: "Preference not found!" }, status: :not_found
    end
  end

  # PUT/PATCH /users/:user_id/preferences
  def update
    if @user.update_or_create_preference!(preference_params)
      render json: @user.preference, status: :ok
    else
      render json: { error: "Preference not found!" }, status: :not_found
    end
  end

  private

  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:user_id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def preference_params
    # Explicitly whitelist only pagination for now
    params.require(:user_preference).permit(:pagination)
  end
end
