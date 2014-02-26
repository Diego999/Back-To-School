class Discussion < ActiveRecord::Base
  has_many :events
  has_many :messages
  has_and_belongs_to_many :promotions
  has_and_belongs_to_many :users
  has_and_belongs_to_many :establishments
end
