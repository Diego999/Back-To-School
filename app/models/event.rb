class Event < ActiveRecord::Base
  belongs_to :discussion
  belongs_to :user

  validates :date, :name, :location, presence: true
end
