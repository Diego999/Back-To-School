class Event < ActiveRecord::Base
  include Authority::Abilities
  self.authorizer_name = 'EventAuthorizer'

  belongs_to :discussion
  belongs_to :user

  validates :date, :name, :location, presence: true
  validates :discussion, presence: true
  validates :user, presence: true
end
