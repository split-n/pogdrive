class ChangeColumnToEpisode < ActiveRecord::Migration[5.1]
  def change
    change_column :episodes, :podcast_id, :integer, null: false
    change_column :episodes, :gd_name, :string, null: false
    change_column :episodes, :gd_id, :string, null: false
    change_column :episodes, :gd_web_view_link, :string, null: false
    change_column :episodes, :gd_created_time, :datetime, null: false
    change_column :episodes, :gd_modified_time, :datetime, null: false
    change_column :episodes, :gd_mime_type, :string, null: false
    change_column :episodes, :gd_size, :integer, null: false

    add_index :episodes, [:podcast_id, :gd_id], unique: true
  end
end
