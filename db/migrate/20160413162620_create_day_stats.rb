class CreateDayStats < ActiveRecord::Migration
  def change
    create_table :day_stats do |t|
      t.datetime :date
      t.integer :avg
      t.integer :ab
      t.integer :h
      t.integer :bb
      t.integer :so
      t.integer :r
      t.integer :sb
      t.integer :hr
      t.integer :rbi
      t.integer :single
      t.integer :double
      t.integer :triple
      t.integer :playercard_id
      t.integer :fantasy_points

      t.timestamps null: false
    end
  end
end
