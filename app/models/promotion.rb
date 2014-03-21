class Promotion < ActiveRecord::Base
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
end
