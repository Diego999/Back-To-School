class AddPromotionIdToFollowers < ActiveRecord::Migration
  def change
    add_reference :followers, :promotion, index: true
  end
end
