class AddAttachmentPictureToPlayercards < ActiveRecord::Migration
  def self.up
    change_table :playercards do |t|
      t.attachment :picture
    end
  end

  def self.down
    remove_attachment :playercards, :picture
  end
end
