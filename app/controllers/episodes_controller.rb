class EpisodesController < ApplicationController
  def show
    if params[:sk].nil? || params[:sk] != Rails.application.secrets.podcast_secret_key
      render plain: "Forbidden", status: 403
      return
    end

    episode = Episode.find(params[:id])
    send_data(episode.get_content, type: episode.gd_mime_type)
  end
end
