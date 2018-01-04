class PodcastsController < ApplicationController
  def show
    if params[:sk].nil? || params[:sk] != Rails.application.secrets.podcast_secret_key
      render plain: "Forbidden", status: 403
      return
    end

    @podcast = Podcast.find_by(id: params[:id])
    if @podcast.nil?
      render plain: "Not Found", status: 404
      return
    end
  end
end
