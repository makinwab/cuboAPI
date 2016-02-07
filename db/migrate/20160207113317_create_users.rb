class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, unique: true
      t.string :password
      t.string :token

      t.timestamps null: false
    end
  end
end
