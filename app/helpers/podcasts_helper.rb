module PodcastsHelper
  def episode_file_url(ep)
    episode_url(ep, format: ep.extension,
                  sk: Rails.application.secrets.podcast_secret_key)
  end
end
