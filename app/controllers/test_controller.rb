require 'google/apis/drive_v3'

class TestController < ApplicationController
  def index
    drive = Google::Apis::DriveV3::DriveService.new
    console

  end
end
