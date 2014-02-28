class User < ActiveRecord::Base
  has_and_belongs_to_many :promotions
  belongs_to :establishment
  has_many :messages
  has_many :events
  has_many :followers
  has_many :follows_promotions, :class_name => 'Promotion', through: :followers
  has_and_belongs_to_many :discussions

  validates :firstname, :lastname, :mail, :password, :salt, presence: true
end
