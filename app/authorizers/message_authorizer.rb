class MessageAuthorizer < ApplicationAuthorizer

  def creatable_by?(user)
    resource.discussion.updatable_by?(user)
  end
end
