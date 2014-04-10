class EstablishmentAuthorizer < ApplicationAuthorizer

  def readable_by?(user)
    resource.get_users.include?(user)
  end
end
