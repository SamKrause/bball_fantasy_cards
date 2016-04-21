class ComputerTeam < ActiveRecord::Base
  has_many :computer_day_points

  attr_accessible :logo
  has_attached_file :logo, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing_logo.png"
  validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\Z/
end
