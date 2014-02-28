class AddPromotionIdToUsers < ActiveRecord::Migration
  def change
    remove_column :users, :promotion_id
  end
end
