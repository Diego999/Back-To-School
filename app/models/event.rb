class Event < ActiveRecord::Base
  include Authority::Abilities
  self.authorizer_name = 'EventAuthorizer'

  belongs_to :discussion
  belongs_to :user

  validates :date, :name, :location, presence: true
end
