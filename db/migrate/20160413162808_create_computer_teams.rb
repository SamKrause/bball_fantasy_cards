class CreateComputerTeams < ActiveRecord::Migration
  def change
    create_table :computer_teams do |t|
      t.string :team_name
      t.string :gameday_id
      t.string :team_city

      t.timestamps null: false
    end
  end
end
