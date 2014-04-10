class Message < ActiveRecord::Base
  include Authority::Abilities
  self.authorizer_name = 'MessageAuthorizer'

  belongs_to :discussion
  belongs_to :user

  validates :message, presence: true
end
