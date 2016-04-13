class CreateSeasonStats < ActiveRecord::Migration
  def change
    create_table :season_stats do |t|
      t.integer :avg
      t.integer :ab
      t.integer :h
      t.integer :bb
      t.integer :so
      t.integer :r
      t.integer :sb
      t.integer :hr
      t.integer :rbi
      t.integer :year
      t.integer :playercard_id

      t.timestamps null: false
    end
  end
end
