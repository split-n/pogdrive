class CreateEpisodes < ActiveRecord::Migration[5.1]
  def change
    create_table :episodes do |t|
      t.references :podcast, foreign_key: true
      t.string :gd_name
      t.string :gd_id
      t.string :gd_web_view_link
      t.datetime :gd_created_time
      t.datetime :gd_modified_time
      t.string :gd_mime_type
      t.integer :gd_size

      t.timestamps
    end
  end
end
