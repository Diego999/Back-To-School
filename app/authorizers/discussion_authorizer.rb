class DiscussionAuthorizer < ApplicationAuthorizer

  def readable_by?(user)
    user.discussion_participant?(resource)
  end

  def creatable_by?(user)
    valid = true
    user_participant = false

    followed_promotions = user.accepted_followed_promotions
    promotions = user.promotions

    # check if the current user participates to all the potential promoitions.
    resource.promotions.each do |p|
      valid &= followed_promotions.includes?(p)
      valid &= promotions.includes?(p)
      promotions.users.includes?(user)
    end


    # check if all potential participants are in current establishment.
    current_establishment = user.general_establishment
    resource.participants.each do |u|
      valid &= (current_establishment==u.general_establishment)
    end

    # validate if current user has the rights to create discussion with an establishement as participant.
    if resource.establishments.count > 0 && !user.est_admin
      valid &= false
    elsif resource.establishments.count > 0 && user.est_admin
      resource.establishments.each do |e|
        valid &= (e == user.general_establishment)
      end
    end

    #check if current user is in participant list.
    valid &= resource.participants.include?(user)
  end

  def updatable_by?(user)
    resource.participants.include?(user)
  end
end