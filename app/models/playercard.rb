class Playercard < ActiveRecord::Base
  has_many :user_playercards
  has_many :users, :through => :user_playercards
  has_many :playercard_games
  has_many :games, :through => :playercard_games
  has_many :season_stats
  has_many :day_stats

  has_attached_file :picture, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/

end
