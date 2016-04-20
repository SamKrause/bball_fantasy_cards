class ChangeUsernameColumnToTeamName < ActiveRecord::Migration
  def change
    rename_column :users, :username, :team_name
  end
end
