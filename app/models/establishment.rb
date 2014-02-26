class Establishment < ActiveRecord::Base
  has_many :promotions
  has_many :users
  has_and_belongs_to_many :discussions

  validates :name, presence:true
end
