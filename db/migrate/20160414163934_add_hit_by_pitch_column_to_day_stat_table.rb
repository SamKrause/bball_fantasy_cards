class AddHitByPitchColumnToDayStatTable < ActiveRecord::Migration
  def change
    remove_column :day_stats, :avg
    add_column :day_stats, :hbp, :integer
  end
end
