class AddColumnToEpisode < ActiveRecord::Migration[5.1]
  def change
    add_column :episodes, :get_order, :integer, null: false, default: 0
  end
end
