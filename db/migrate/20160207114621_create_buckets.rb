class CreateBuckets < ActiveRecord::Migration
  def change
    create_table :buckets do |t|
      t.string :name
      t.integer :user_id, foreign_key: true, add_index: true

      t.timestamps null: false
    end
  end
end
