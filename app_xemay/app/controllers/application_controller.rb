class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!, except: [:index, :show]
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale
  before_filter :set_global_search_variable

  def set_global_search_variable
    @q = Review.ransack params[:q]
  end

  include ApplicationHelper

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  def default_url_options options = {}
    {locale: I18n.locale}
  end

  protected
  def current_ability
    @current_ability ||= Ability.new current_user
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u|
      u.permit(:email, :password, :password_confirmation, :name) }

    devise_parameter_sanitizer.for(:account_update) { |u|
      u.permit(:avatar, :name, :password, :password_confirmation, :current_password)
    }
  end

  def after_sign_in_path_for resource
    current_user.decorate.allow_access_admin ? root_path : courses_path
  end

  private
  def after_sign_in_path_for resource
    stored_location_for(resource) || root_path
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
