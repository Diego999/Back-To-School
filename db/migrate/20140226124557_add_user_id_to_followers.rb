class AddUserIdToFollowers < ActiveRecord::Migration
  def change
    add_reference :followers, :user, index: true
  end
end
