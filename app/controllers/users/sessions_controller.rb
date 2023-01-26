# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /users/:id
  def show
    # Print the datetime in EDT zone.
    Time.zone = 'Eastern Time (US & Canada)'
    @user_hosted_events = {}
    User.where('users.id' => params[:id]).includes(:hosted_events).each do |user|
      @user_hosted_events[user.name] = user.hosted_events.map { |event| event }
    end
  end

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
