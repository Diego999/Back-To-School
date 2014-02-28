class Discussion < ActiveRecord::Base
  include Authority::Abilities

  has_many :messages
  has_and_belongs_to_many :participants, class_name: "User"
end
