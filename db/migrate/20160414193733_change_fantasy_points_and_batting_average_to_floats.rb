class ChangeFantasyPointsAndBattingAverageToFloats < ActiveRecord::Migration
  def change
    change_column(:season_stats, :avg, :float)
    change_column(:day_stats, :fantasy_points, :float)
    change_column(:computer_day_points, :fantasy_points, :float)
  end
end
