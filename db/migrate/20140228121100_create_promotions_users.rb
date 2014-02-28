class CreatePromotionsUsers < ActiveRecord::Migration
  def change
    create_table :promotions_users do |t|
      t.references :promotion
      t.references :user
    end
    add_index :promotions_users, [:user_id, :promotion_id]
    add_index :promotions_users, :promotion_id
  end
end
