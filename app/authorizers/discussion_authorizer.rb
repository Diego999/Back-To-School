class DiscussionAuthorizer < ApplicationAuthorizer

  def readable_by?(user)
    user.discussion_participant?(resource)
  end
end