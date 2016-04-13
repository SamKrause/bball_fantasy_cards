class CreateComputerDayPoints < ActiveRecord::Migration
  def change
    create_table :computer_day_points do |t|
      t.integer :computer_team_id
      t.integer :fantasy_points
      t.datetime :date

      t.timestamps null: false
    end
  end
end
