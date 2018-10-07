class ChangeDataTypeGdSizeOfEpisodes < ActiveRecord::Migration[5.2]
  def change
    change_column :episodes, :gd_size, :bigint
  end
end
