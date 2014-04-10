class UserAuthorizer < ApplicationAuthorizer

  def readable_by?(user)
    user.general_establishment.get_users.include?(resource)
  end
end
