class GoogleDriveClient
  OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'
  SCOPE = 'https://www.googleapis.com/auth/drive'
  USER_ID = "dummy_the_user"

  # @param client_id [String]
  # @param client_secret [String]
  def initialize(client_id = Rails.application.secrets.google_client_id,
                 client_secret = Rails.application.secrets.google_client_secret)
    @client_id = client_id
    @client_secret = client_secret
  end

  # @yield [String] Callback to get code. Parameter is auth url.
  # @yieldreturn [String] Auth code.
  # @return [String] Message
  def authorize(&input_block)
    client_id = Google::Auth::ClientId.new(@client_id, @client_secret)
    token_store = GoogleAuthDbTokenStore.new
    authorizer = Google::Auth::UserAuthorizer.new(client_id, SCOPE, token_store)

    credentials = authorizer.get_credentials(USER_ID)
    if credentials.nil?
      url = authorizer.get_authorization_url(base_url: OOB_URI)
      code = input_block.call(url)
      credentials = authorizer.get_and_store_credentials_from_code(
        user_id: USER_ID, code: code, base_url: OOB_URI)

      'Authorization success.'
    else
      'Already authorized.'
    end
  end

  def destroy_auth
    Googleauth.destroy_all
    "Destroyed authorized tokens."
  end

  def list_files(q: , order_by: , page_size:)
    drive = get_drive
    drive.list_files(q: q, order_by: order_by, page_size: page_size,
                fields: 'files(createdTime, id, mime_type, modifiedTime, name, size, webViewLink)')

  end

  private
  def get_drive
    return @drive if @drive

    client_id = Google::Auth::ClientId.new(@client_id, @client_secret)
    token_store = GoogleAuthDbTokenStore.new
    authorizer = Google::Auth::UserAuthorizer.new(client_id, SCOPE, token_store)

    credentials = authorizer.get_credentials(USER_ID)
    if credentials.nil?
      raise "Not authorized."
    end

    @drive = Google::Apis::DriveV3::DriveService.new
    @drive.authorization = credentials
    @drive
  end
end
