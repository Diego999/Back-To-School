class PromotionAuthorizer < ApplicationAuthorizer

  def readable_by?(user)
    user.general_establishment.promotions.include?(resource)
  end

  def updatable_by?(user)
    resource.get_all_users.include?(user)
  end
end
