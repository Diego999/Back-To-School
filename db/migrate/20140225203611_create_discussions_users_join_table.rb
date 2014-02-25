class CreateDiscussionsUsersJoinTable < ActiveRecord::Migration
  def change
    create_table :discussions_users, id: false do |t|
      t.integer :user_id
      t.integer :discussion_id
    end
  end
end
