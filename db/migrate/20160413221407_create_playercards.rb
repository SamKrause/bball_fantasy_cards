class CreatePlayercards < ActiveRecord::Migration
  def change
    create_table :playercards do |t|
      t.string :first_name
      t.string :last_name
      t.string :pro_team_name
      t.string :pro_team_city
      t.string :position
      t.integer :number
      t.integer :gameday_id
      t.integer :cbs_id
      t.integer :rank

      t.timestamps null: false
    end
  end
end
