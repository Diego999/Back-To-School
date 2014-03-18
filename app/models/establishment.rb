class Establishment < ActiveRecord::Base
  has_many :promotions
  has_many :users
  has_and_belongs_to_many :discussions

  validates :name, presence:true

  def get_discussion
    Discussion.joins([:establishments]).where('establishments.id = ?', self)
  end
end
