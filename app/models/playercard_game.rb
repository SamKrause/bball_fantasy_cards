class PlayercardGame < ActiveRecord::Base
  belongs_to :playercard
  belongs_to :game
end
