class DevicesController < ApplicationController
  before_action :authenticate

  def index
    @devices = Device.all
  end
end
