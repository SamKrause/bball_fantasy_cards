class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :user_id
      t.integer :computer_day_point_id
      t.datetime :date
      t.boolean :user_win
      t.integer :user_points

      t.timestamps null: false
    end
  end
end
