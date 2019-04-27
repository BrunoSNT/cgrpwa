# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  layout "application", only: [:edit]

  # GET /resource/sign_up
  def new
    @user_occupation_core = UserCoreOccupation.new
    super
  end

  # POST /resource
  def create
    super
    @user = User.find_by(email: params[:user][:email])
    @user_occupation_core = UserCoreOccupation.new(core_id: params[:user_core_occupation][:core_id], occupation_id: params[:user_core_occupation][:occupation_id], user_id: @user.id)
    @user_occupation_core.save!
  end

  # GET /resource/edit
  def edit
    require "http"
    require "json"
    @user_id = current_user.clockify_user_id

    if current_user.clockify_active_workspace_id
      @active_workspace = current_user.clockify_active_workspace_id
    else
      response_workspace_active = HTTP.headers('Content-Type': 'application/json', 'x-api-key': "#{current_user.clockify_key}")
                                      .get("https://api.clockify.me/api/users/#{@user_id}/")

      @active_workspace = JSON.parse(response_workspace_active)["activeWorkspace"]
      current_user.clockify_active_workspace_id = @active_workspace
      current_user.save
    end

    response = HTTP.headers('Content-Type': 'application/json', 'x-api-key': "#{current_user.clockify_key}")
        .get("https://api.clockify.me/api/workspaces/#{@active_workspace}/timeEntries/user/#{@user_id}")

    @entries = JSON.parse(response)
    # uri = URI('https://api.clockify.me/api/workspaces/5b2d9144b079872d5bcf99e5/timeEntries/user/5b2d8db3b079872d5bcf996b/entriesInRange')
    # uri = URI('https://api.clockify.me/api/workspaces/5b2d9144b079872d5bcf99e5/timeEntries/user/5b2d8db3b079872d5bcf996b')
    @main_page = "Pessoal"
    @page_title = "Perfil"
    @user_projects = current_user.projects.count
    super
  end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
  #
  private

  def sign_up_params
    params.require(:user).permit(
        :email,
        :username,
        :password,
        :password_confirmation,
        :first_name,
        :last_name,
        :birthdate,
        :enterdate,
        :git_url,
        :phone,
        :avatar
    )
  end

  def account_update_params
    params.require(:user).permit(
        :email,
        :username,
        :password,
        :password_confirmation,
        :first_name,
        :last_name,
        :birthdate,
        :enterdate,
        :git_url,
        :phone,
        :current_password,
        :avatar,
        :clockify_user_id,
        :clockify_active_workspace_id,
        :clockify_refresh_token,
        :clockify_key
    )
  end
end
