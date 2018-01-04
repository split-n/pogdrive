class Episode < ApplicationRecord
  belongs_to :podcast
  # get_order: below files first 
  scope :get_ordered, -> { order("get_order desc") }

  def title
    gd_name
  end

  def extension
    File.extname(gd_name)[1..-1]
  end

  def get_content
    client = GoogleDriveClient.new
    client.get_file_content(gd_id)
  end
end
