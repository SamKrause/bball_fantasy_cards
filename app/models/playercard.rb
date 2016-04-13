class Playercard < ActiveRecord::Base
  has_many :user_playercards
  has_many :users, :through => :user_playercards
  has_many :playercard_games
  has_many :games, :through => :playercard_games
  has_many :season_stats
  has_many :day_stats
end
