class AddDiscussionIdToEvents < ActiveRecord::Migration
  def change
    add_reference :events, :discussion, index: true
  end
end
