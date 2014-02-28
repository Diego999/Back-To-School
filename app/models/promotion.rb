class Promotion < ActiveRecord::Base
  belongs_to :establishment
  has_and_belongs_to_many :students, :class_name => 'User'
  has_many :followers
  has_many :users, through: :followers
  has_and_belongs_to_many :discussions

  validates :name, presence: true
end
