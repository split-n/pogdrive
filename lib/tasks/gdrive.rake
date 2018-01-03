require 'googleauth'
require 'googleauth/stores/file_token_store'

namespace :gdrive do
  desc "Google Drive"
  task auth: :environment do
    OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'
    USER_ID = "dummy_the_user"

    scope = 'https://www.googleapis.com/auth/drive'
    client_id = Google::Auth::ClientId.from_file(Rails.root + 'config/client_secrets.json')

    token_store = GoogleAuthDbTokenStore.new
    authorizer = Google::Auth::UserAuthorizer.new(client_id, scope, token_store)

    credentials = authorizer.get_credentials(USER_ID)
    if credentials.nil?
      url = authorizer.get_authorization_url(base_url: OOB_URI)
      puts 'Open'
      puts url
      puts "in your browser and enter the resulting code:"
      code = STDIN.gets
      credentials = authorizer.get_and_store_credentials_from_code(
        user_id: USER_ID, code: code, base_url: OOB_URI)
      puts 'Authorization success.'
    else
      puts "Already authorized."
    end
  end

end
