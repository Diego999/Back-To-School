class Message < ActiveRecord::Base
  belongs_to :author, class_name: "User", foreign_key: "author_id"
  belongs_to :discussion
end
