namespace :podcast do
  desc "Renew all episodes"
  task renew_all: :environment do
    Podcast.all.each do |podcast|
      podcast.renew_episodes
      puts "Renewed: #{podcast.title}"
    end
  end
end