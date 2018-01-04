class ChangeColumnToPodcast < ActiveRecord::Migration[5.1]
  def change
    change_column :podcasts, :title, :string, null: false
    change_column :podcasts, :query, :string, null: false
    change_column :podcasts, :order_by, :string, null: false, default: 'createdTime desc'
    change_column :podcasts, :max_count, :integer, null: false, default: 10
  end
end
