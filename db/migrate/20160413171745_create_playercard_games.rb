class CreatePlayercardGames < ActiveRecord::Migration
  def change
    create_table :playercard_games do |t|
      t.integer :playercard_id
      t.integer :game_id

      t.timestamps null: false
    end
  end
end
