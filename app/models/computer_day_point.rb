class ComputerDayPoint < ActiveRecord::Base
  has_many :games
  belongs_to :computer_team
end
