class MeasuresController < ApplicationController
  before_action :authenticate
  before_action :find_device

  def index
    @measures = Measures::Filter.new(params, @device)
  end

  private

  def find_device
    @device = Device.find(params[:device_id])
  end
end
