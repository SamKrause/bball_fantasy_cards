class AddAttachmentLogoToComputerTeams < ActiveRecord::Migration
  def self.up
    change_table :computer_teams do |t|
      t.attachment :logo
    end
  end

  def self.down
    remove_attachment :computer_teams, :logo
  end
end
