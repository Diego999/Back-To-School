class AddPromotionIdToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :promotion, index: true
  end
end
