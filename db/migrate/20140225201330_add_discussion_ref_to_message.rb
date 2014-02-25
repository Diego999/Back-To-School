class AddDiscussionRefToMessage < ActiveRecord::Migration
  def change
    add_reference :messages, :discussion, index: true, null: false
  end
end
