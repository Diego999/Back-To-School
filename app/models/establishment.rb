class Establishment < ActiveRecord::Base
  include Authority::Abilities
  self.authorizer_name = 'EstablishmentAuthorizer'

  has_many :promotions
  has_many :users
  has_and_belongs_to_many :discussions

  validates :name, presence:true

  def get_discussion
    Discussion.joins([:establishments]).where('establishments.id = ?', self)
  end

  def get_users
    User.joins([:promotions]).where('promotions.establishment_id = ?', self)
  end
end
