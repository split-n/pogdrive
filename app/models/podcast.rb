class Podcast < ApplicationRecord
  has_many :episodes, dependent: :destroy

  def renew_episodes
    ActiveRecord::Base.transaction do
      episodes.destroy_all

      client = GoogleDriveClient.new
      response = client.list_files(q: query, order_by: order_by, page_size: max_count)
      response.files.each do |file|
        episodes.create(
          gd_name: file.name, gd_id: file.id, gd_web_view_link: file.web_view_link,
          gd_created_time: file.created_time, gd_modified_time: file.modified_time,
          gd_mime_type: file.mime_type, gd_size: file.size
        )
      end
    end
  end
end
