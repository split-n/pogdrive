class Episode < ApplicationRecord
  belongs_to :podcast

  def extension
    File.extname(gd_name)[1..-1]
  end

  def get_content
    client = GoogleDriveClient.new
    client.get_file_content(gd_id)
  end
end
