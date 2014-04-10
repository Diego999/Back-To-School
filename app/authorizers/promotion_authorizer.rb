class PromotionAuthorizer < ApplicationAuthorizer

  def readable_by?(user)
    user.general_establishment.promotions.include?(resource)
  end
end
