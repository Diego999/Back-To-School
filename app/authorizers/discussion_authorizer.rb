class DiscussionAuthorizer < ApplicationAuthorizer

  def readable_by?(user)
    resource.participants.include?(user)
  end
end