class CreateGoogleauths < ActiveRecord::Migration[5.1]
  def change
    create_table :googleauths do |t|
      t.string :key, null: false
      t.text :value

      t.timestamps
    end
    add_index :googleauths, :key, unique: true
  end
end
