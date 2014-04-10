class Promotion < ActiveRecord::Base
  include Authority::Abilities
  self.authorizer_name = 'PromotionAuthorizer'

  belongs_to :establishment
  has_and_belongs_to_many :students, :class_name => 'User'
  has_many :followers
  has_many :users, through: :followers
  has_and_belongs_to_many :discussions

  validates :name, presence: true

  def get_discussion
    Discussion.joins([:promotions]).where('promotions.id = ?', self)
  end

  def leave(current_user)
    followers.each do |f|
      if f.user.id == current_user.id
        f.destroy
        break
      end
    end
  end

  def user_is_in(user)
    o = false
    user.promotions.each do |p|
      if p.id == id
        o = true
        break
      end
    end
    unless o
      followers.each do |f|
        a = f.user.id
        b = user.id
        if f.user.id == user.id
          o = true
          break
        end
      end
    end
    o
  end
end
