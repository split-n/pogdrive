class Podcast < ApplicationRecord
  has_many :episodes, dependent: :destroy

  def renew_episodes
    ActiveRecord::Base.transaction do
      episodes.destroy_all
    end
  end
end
