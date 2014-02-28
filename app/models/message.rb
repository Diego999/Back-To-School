class Message < ActiveRecord::Base
  include Authority::Abilities

  belongs_to :author, class_name: "User", foreign_key: "author_id"
  belongs_to :discussion
end
