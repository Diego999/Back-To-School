class UserValidator < ActiveModel::Validator

  def validate(record)
    if record.est_admin == true && record.establishment == nil
      record.errors[:est_admin] << "Define an establishment if you want to grant establishement admin rights."
    end
    if record.student == true && record.professor == true
      record.errors[:est_admin] << "Not allowed to be student and professor at the same time."
    end
    if (record.student == true || record.professor == true) && record.promotions.count == 0
      record.errors[:promotions] << "Not allowed to create a professor or a student, without an associated promotion."
    end
  end
end


class User < ActiveRecord::Base
  devise :database_authenticatable,
         :rememberable, :validatable

  include Authority::UserAbilities
  include Authority::Abilities
  self.authorizer_name = 'UserAuthorizer'

  has_and_belongs_to_many :promotions
  belongs_to :establishment
  has_many :messages
  has_many :events
  has_many :followers
  has_many :follows_promotions, :class_name => 'Promotion', through: :followers
  has_and_belongs_to_many :discussions

  validates_presence_of :firstname, :message => "Firstname required."
  validates_presence_of :lastname, :message => "Lastname required."
  validates_length_of :email, :within => 6..100, :message => "E-Mail address length has to be minimum 6 characters.", :allow_blank => false
  validates :promotions, :length => { :minimum => 1 }
  validates_with UserValidator
  
  def get_default_promotion
    return promotions[0]
  end

  def get_complete_name
    firstname + " " + lastname
  end
  
  def get_all_discussions
    output = get_discussion_private + get_discussion_establishment
    get_discussion_promotion(output)
    output
  end

  def get_all_events
    events = []
    get_all_discussions.each do |d|
      events.concat(d.events)
    end
    events
  end

  def get_discussion_private
    Discussion.joins([:users]).where('users.id = ?', self)
  end

  def get_discussion_promotion(discussions)
    self.promotions.each do |promotion|
      discussions.concat(promotion.get_discussion)
    end
  end

  def get_discussion_establishment
    general_establishment.get_discussion
  end

  def accepted_followed_promotions
    Promotion.joins(:followers).where("followers.user_id = ?", self.id)
  end

  def accepted_followed_discussions
    Discussion.joins("INNER JOIN discussions_promotions ON discussions.id = discussions_promotions.discussion_id") \
              .joins("INNER JOIN promotions ON discussions_promotions.promotion_id = promotions.id") \
              .joins("INNER JOIN followers ON promotions.id = followers.promotion_id AND followers.accepted = true") \
              .where("followers.user_id = %s", self.id)
  end

  def promotions_discussions
    Discussion.joins("INNER JOIN discussions_promotions ON discussions.id = discussions_promotions.discussion_id") \
              .joins("INNER JOIN promotions ON discussions_promotions.promotion_id = promotions.id") \
              .joins("INNER JOIN promotions_users ON promotions.id = promotions_users.promotion_id") \
              .where("promotions_users.user_id = %s", self.id)
  end

  def general_establishment
    est = nil

    if establishment != nil
      est = establishment
    else
      est = promotions.first.establishment
    end

    est
  end

  def establishment_discussions
    Discussion.joins(:establishments).where("establishments.id = ?", self.general_establishment)
  end

  def discussion_participant?(discussion)
    discussions.include?(discussion) || promotions_discussions.include?(discussion) || accepted_followed_discussions.include?(discussion) || establishment_discussions.include?(discussion)
  end

end
