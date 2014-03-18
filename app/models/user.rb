class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_and_belongs_to_many :promotions
  belongs_to :establishment
  has_many :messages
  has_many :events
  has_many :followers
  has_many :follows_promotions, :class_name => 'Promotion', through: :followers
  has_and_belongs_to_many :discussions

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
    get_default_promotion.establishment.get_discussion
  end

end
