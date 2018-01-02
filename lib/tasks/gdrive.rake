namespace :gdrive do
  desc "Google Drive tasks"
  task :auth => :environment do
    require 'googleauth'
    require 'googleauth/stores/file_token_store'

    OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'
    TOKENS_TMP_PATH = Rails.root + 'tmp/tokens.yaml'
    USER_ID = "dummy"

    scope = 'https://www.googleapis.com/auth/drive'
    client_id = Google::Auth::ClientId.from_file(Rails.root + "config/client_secrets.json")

    # FileTokenStoreだが、DBに保存する
    tokens = Setting.find_or_create_by(name: "GOOGLE_USER_SECRETS")
    if tokens.value
      File.write(TOKENS_TMP_PATH, tokens.value)
    end

    token_store = Google::Auth::Stores::FileTokenStore.new(
      :file => TOKENS_TMP_PATH)
    authorizer = Google::Auth::UserAuthorizer.new(client_id, scope, token_store)

    credentials = authorizer.get_credentials(USER_ID)
    if credentials.nil?
      url = authorizer.get_authorization_url(base_url: OOB_URI )
      puts "Open #{url} in your browser and enter the resulting code:"
      code = STDIN.gets
      credentials = authorizer.get_and_store_credentials_from_code(
        user_id: USER_ID, code: code, base_url: OOB_URI)

      new_tokens_value = File.read(TOKENS_TMP_PATH)
      tokens.value = new_tokens_value
      tokens.save!
    end
  ensure
    File.delete(TOKENS_TMP_PATH) rescue nil
  end
end
