# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token, :only => [:facebook, :linkedin, :google_oauth2, :spotify]

  def spotify
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "Spotify") if is_navigational_format?
    else
      user = User.find_by(email: @user.email)
      if user.present?
        sign_in_and_redirect @user , event: :authentication
      else
        session["devise.google_data"] = request.env["omniauth.auth"].except(:extra) 
        redirect_to new_user_registration_url
      end
    end
  end


  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication 
      set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
    else
      user = User.find_by(email: @user.email)
      if user.present?
        sign_in_and_redirect @user , event: :authentication
      else
        session["devise.google_data"] = request.env["omniauth.auth"].except(:extra) 
        redirect_to new_user_registration_url
      end
    end
  end

  def linkedin
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "Linkedin") if is_navigational_format?
    else
     user = User.find_by(email: @user.email)
      if user.present?
        sign_in_and_redirect @user , event: :authentication
      else
        session["devise.google_data"] = request.env["omniauth.auth"].except(:extra) 
        redirect_to new_user_registration_url
      end
    end
  end

  def google_oauth2
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "Google") if is_navigational_format?
    else
      user = User.find_by(email: @user.email)
      if user.present?
        sign_in_and_redirect @user , event: :authentication
      else
        session["devise.google_data"] = request.env["omniauth.auth"].except(:extra) 
        redirect_to new_user_registration_url
      end
    end
  end

  def failure

  end
end
