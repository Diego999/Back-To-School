class Discussion < ActiveRecord::Base
  include Authority::Abilities
  self.authorizer_name = 'DiscussionAuthorizer'

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

  def get_last_message_date
    messages = self.messages.order('created_at DESC')
    if messages.size == 0
      created_at
    else
      messages[0].created_at
    end
  end

  def get_items()
    return messages + events
  end

   def self.accept(current_user, user, promotion)
    follower = nil
    promotion.followers.each do |f|
      if f.user == user
        follower = f
      end
    end
    if promotion.students.exists?(current_user) and !follower.nil? and !follower.accepted
      follower.accepted = true
      follower.save
    end
  end

  def self.already_exists(_users, _promotions, _establishments)
    discussions = Discussion.all
    users = Discussion.convert_activerecord_to_array(_users)
    promotions = Discussion.convert_activerecord_to_array(_promotions)
    establishments = Discussion.convert_activerecord_to_array(_establishments)

    kept_discussions = []
    discussions.each do |d|
      aa = Discussion.already_exists_check_array(users, Discussion.convert_activerecord_to_array(d.users))
      bb = Discussion.already_exists_check_array(promotions, Discussion.convert_activerecord_to_array(d.promotions))
      cc = Discussion.already_exists_check_array(establishments, Discussion.convert_activerecord_to_array(d.establishments))
      if aa and bb and cc
        kept_discussions.append(d)
        break
      end
    end
    kept_discussions
  end

  def self.convert_activerecord_to_array(a)
    a.sort_by!(&:id)
    o = []
    a.each do |d|
      o.append(d)
    end
    o
  end

  def self.already_exists_check_array(a, b)
    fit = (a.empty? and b.empty?)
    if a.size > 0 and a.size == b.size
      fit = true
      b.each_with_index do |u, i|
        if u.id != a[i].id
          fit = false
        end
        unless fit
          break
        end
      end
    end
    fit
  end

  def self.discussion_exists_between_2_users(u, v)
    out = false
    (Discussion.convert_activerecord_to_array(u.discussions) & Discussion.convert_activerecord_to_array(v.discussions)).each do |d|
      if d.users.size == 2
        out = true
        break
      end
    end
    out
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
