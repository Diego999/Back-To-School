class Promotion < ActiveRecord::Base
  include Authority::Abilities
  self.authorizer_name = 'PromotionAuthorizer'

  belongs_to :establishment
  has_and_belongs_to_many :students, :class_name => 'User'
  has_many :followers
  has_many :users, through: :followers
  has_and_belongs_to_many :discussions

  validates :name, presence: true
  validates :establishment, presence: true
  validates :discussions, :length => {:minimum => 1}

  def get_discussion
    Discussion.joins([:promotions]).where('promotions.id = ?', self)
  end

  def get_accepted_followers
    User.joins([:followers]).where('followers.promotion_id = ?', self).where('followers.accepted = 1')
  end

  def get_all_users
    (get_accepted_followers + students).uniq
  end

  def accept(current_user, user)
    follower = nil
    followers.each do |f|
      if f.user == user
        follower = f
      end
    end
    if students.exists?(current_user) or get_accepted_followers.exists?(current_user) and !follower.nil? and !follower.accepted
      follower.accepted = true
      follower.save
    end
  end

  def leave(current_user)
    followers.each do |f|
      if f.user.id == current_user.id
        f.destroy
        break
      end
    end
  end

  def self.search(keyword, establishment)
    if keyword
      Promotion.joins([:establishment]).where('promotions.establishment_id = ?',establishment).where('promotions.name LIKE ?', "%#{keyword}%")
    else
      establishment.promotions
    end
  end
end
