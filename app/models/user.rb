class User < ActiveRecord::Base
  include Authority::UserAbilities
  devise :database_authenticatable

  has_many :messages, class_name: "Message",
           foreign_key: "author_id"
  has_and_belongs_to_many :discussions, class_name: "Discussion"
end
