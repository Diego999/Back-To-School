class RemovePromotionIdToUsers < ActiveRecord::Migration
  def change
    remove_reference :users, :promotion, index: true
  end
end
