class Message < ActiveRecord::Base
  belongs_to :discussion
  belongs_to :user

  validates :message, presence: true
end
