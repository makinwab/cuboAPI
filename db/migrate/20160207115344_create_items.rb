class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.integer :bucket_id, foreign_key: true, add_index: true
      t.boolean :done, default: false

      t.timestamps null: false
    end
  end
end
