require 'googleauth'
require 'googleauth/stores/file_token_store'

namespace :gdrive do
  desc "Register Google Drive account"
  task auth: :environment do
    client = GoogleDriveClient.new(Rails.application.secrets.google_client_id, Rails.application.secrets.google_client_secret)
    puts client.authorize { |auth_url|
      puts 'Open'
      puts auth_url
      puts "in your browser and enter the resulting code:"
      STDIN.gets
    }
  end

  desc "Clear Google Drive account"
  task auth_clear: :environment do
    client = GoogleDriveClient.new(Rails.application.secrets.google_client_id, Rails.application.secrets.google_client_secret)
    puts client.destroy_auth
  end
end
