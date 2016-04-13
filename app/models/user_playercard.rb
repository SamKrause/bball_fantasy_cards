class UserPlayercard < ActiveRecord::Base
  belongs_to :user
  belongs_to :playercard
end
