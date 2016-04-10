class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!, except: [:index, :show]

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  protected
  def current_ability
    @current_ability ||= Ability.new current_user
  end

  private
  def after_sign_in_path_for resource
    stored_location_for(resource) || root_path
  end
end
