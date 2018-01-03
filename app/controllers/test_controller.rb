require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'google/apis/drive_v3'

class TestController < ApplicationController
  def index
    drive = get_drive
    @files  = drive.list_files(q: params[:q])

    console
  end

  def item
    drive = get_drive

    id = params[:id]
    file = drive.get_file(id)
    file_content = StringIO.new
    drive.get_file(id, download_dest:  file_content)

    send_data(file_content.string.force_encoding('binary'), type: file.mime_type)
  end

  private
  def get_drive
    tokens_tmp_path = Rails.root + 'tmp/tokens.yaml'
    user_id = "dummy"

    scope = 'https://www.googleapis.com/auth/drive'
    client_id = Google::Auth::ClientId.from_file(Rails.root + "config/client_secrets.json")

    tokens = Setting.find_or_create_by(name: "GOOGLE_USER_SECRETS")
    if tokens.value
      File.write(tokens_tmp_path, tokens.value)
    else
      raise "should run rake gdrive:auth"
    end

    token_store = Google::Auth::Stores::FileTokenStore.new(
      :file => tokens_tmp_path)
    authorizer = Google::Auth::UserAuthorizer.new(client_id, scope, token_store)

    credentials = authorizer.get_credentials(user_id)

    drive = Google::Apis::DriveV3::DriveService.new
    drive.authorization = credentials
    drive
  end
end
