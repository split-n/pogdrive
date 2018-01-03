class CreatePodcasts < ActiveRecord::Migration[5.1]
  def change
    create_table :podcasts do |t|
      t.string :title
      t.string :query
      t.string :order_by
      t.integer :max_count

      t.timestamps
    end
  end
end
