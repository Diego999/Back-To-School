class EventAuthorizer < ApplicationAuthorizer

  def readable_by?(user)
    resource.discussion.readable_by?(user)
  end

  def creatable_by?(user)
    resource.discussion.updatable_by?(user)
  end
end
