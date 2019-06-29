class NotificationsController < ApplicationController
  before_action :authenticate

  def update
    notification = Notification.find(params[:id])
    notification.update(read: true)

    redirect_back(fallback_location: root_path)
  end
end
