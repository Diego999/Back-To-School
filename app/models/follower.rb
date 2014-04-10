class Follower < ActiveRecord::Base
  belongs_to :promotion
  belongs_to :user

  validates :promotion, presence: true
  validates :user, presence: true
end
