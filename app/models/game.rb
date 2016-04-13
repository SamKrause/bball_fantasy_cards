class Game < ActiveRecord::Base
  belongs_to :user
  belongs_to :computer_day_points
  has_many :playercard_games
  has_many :playercards, :through => :playercard_games
end
