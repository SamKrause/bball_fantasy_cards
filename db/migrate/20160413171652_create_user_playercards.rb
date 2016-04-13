class CreateUserPlayercards < ActiveRecord::Migration
  def change
    create_table :user_playercards do |t|
      t.integer :user_id
      t.integer :playercard_id

      t.timestamps null: false
    end
  end
end
