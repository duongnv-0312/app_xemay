class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_locale

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
