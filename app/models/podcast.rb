class Podcast < ApplicationRecord
  has_many :episodes, dependent: :destroy
  after_save :renew_episodes

  def get_episode_files
    client = GoogleDriveClient.new
    response = client.list_files(q: query, order_by: order_by, page_size: max_count)
    response.files
  end

  def preview_drive_items
    files = get_episode_files
    files.map{|f| {name: f.name, id: f.id}}
  end

  def renew_episodes
    ActiveRecord::Base.transaction do
      files = get_episode_files
      # below files first
      files.reverse.each.with_index do |file,idx|
        ep = episodes.find_or_initialize_by(gd_id: file.id)
        ep.update!(
          gd_name: file.name, gd_web_view_link: file.web_view_link,
          gd_created_time: file.created_time, gd_modified_time: file.modified_time,
          gd_mime_type: file.mime_type, gd_size: file.size,
          get_order: idx
        )
      end

      file_ids = files.map{|f| f.id} 
      episodes.where.not(gd_id: file_ids).destroy_all
    end
  end
end
