class CreateDiscussionsUsers < ActiveRecord::Migration
  def change
    create_table :discussions_users do |t|
      t.references :discussion
      t.references :user
    end
    add_index :discussions_users, [:user_id, :discussion_id]
    add_index :discussions_users, :discussion_id
  end
end
