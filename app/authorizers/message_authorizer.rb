class MessageAuthorizer < ApplicationAuthorizer

  def readable_by?(user)
    false
  end

  def creatable_by?(user)
    false
  end

  def updatable_by?(user)
    false
  end

  def deletable_by?(user)
    false
  end
end
