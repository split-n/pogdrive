class Admin::PodcastsController < ApplicationController
  before_action :set_podcast, only: [:show, :edit, :update, :destroy, :renew_episodes]
  before_action :basic_auth

  # GET /podcasts
  # GET /podcasts.json
  def index
    @podcasts = Podcast.all
  end

  # GET /podcasts/1
  # GET /podcasts/1.json
  def show
  end

  # GET /podcasts/new
  def new
    @podcast = Podcast.new
  end

  # GET /podcasts/1/edit
  def edit
  end

  # POST /podcasts
  # POST /podcasts.json
  def create
    @podcast = Podcast.new(podcast_params)

    respond_to do |format|
      if @podcast.save
        format.html { redirect_to ({id: @podcast.id, action: 'show'}), notice: 'Podcast was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /podcasts/1
  # PATCH/PUT /podcasts/1.json
  def update
    respond_to do |format|
      if @podcast.update(podcast_params)
        format.html { redirect_to ({id: @podcast.id, action: 'show'}), notice: 'Podcast was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /podcasts/1
  # DELETE /podcasts/1.json
  def destroy
    @podcast.destroy
    respond_to do |format|
      format.html { redirect_to admin_podcasts_url, notice: 'Podcast was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # POST /podcasts/1/renew_episodes
  def renew_episodes
    respond_to do |format|
      if @podcast.renew_episodes
        format.html { redirect_to ({id: @podcast.id, action: 'show'}), notice: 'Podcast items were successfully fetched.' }
      else
        format.html { render :show }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_podcast
      @podcast = Podcast.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def podcast_params
      params.require(:podcast).permit(:title, :query, :order_by, :max_count)
    end

    def basic_auth
      authenticate_or_request_with_http_basic do |user, pass|
        user == Rails.application.secrets.admin_user && pass == Rails.application.secrets.admin_pass
      end
    end
end
