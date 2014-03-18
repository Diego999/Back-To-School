class Discussion < ActiveRecord::Base
  has_many :events
  has_many :messages
  has_and_belongs_to_many :promotions
  has_and_belongs_to_many :users
  has_and_belongs_to_many :establishments

  def get_destination_names
    names_list = []
    establishments.each do |est|
      names_list << est.name
    end
    promotions.each do |prom|
      names_list << prom.name
    end
    users.each do |user|
      names_list << user.get_complete_name
    end
    names_list
  end

  def get_items()
    return messages + events
  end

  def fill_sidebar()
    establishments = self.establishments
    promotions = self.promotions
    user = self.users

    participants = []
    participants_follower = []
    establishments.each do |establishment|
      Discussion.add_from_promotion(establishment.promotions, participants, participants_follower)
    end

    Discussion.add_from_promotion(promotions, participants, participants_follower)
    participants.concat(user)

    # We remove the user of follower if he is already in participants
    participants.each do |p|
      participants_follower.reject!{|f| f.user.id == p.id}
    end

    return participants, participants_follower
  end

  def self.add_from_promotion(promotions, participants, participants_follower)
    promotions.each do |promotion|
      participants.concat(promotion.students)
      participants_follower.concat(promotion.followers)
    end
  end
end
