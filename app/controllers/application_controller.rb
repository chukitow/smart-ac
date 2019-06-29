class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :active_notifications

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def active_notifications
    Notification.unreads.with_measure_and_device
  end

  def authenticate
    redirect_to new_session_path if current_user.nil?
  end
end
