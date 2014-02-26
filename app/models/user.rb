class User < ActiveRecord::Base
  belongs_to :promotion
  belongs_to :establishment
  has_many :messages
  has_many :events
  has_many :followers
  has_many :promotions, through: :followers
  has_and_belongs_to_many :discussions

  validates :firstname, :lastname, :mail, :password, :salt, presence: true
end
