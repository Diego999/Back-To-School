class Discussion < ActiveRecord::Base
  has_many :messages
  has_and_belongs_to_many :participants, class_name: "User"
end
