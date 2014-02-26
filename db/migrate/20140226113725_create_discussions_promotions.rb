class CreateDiscussionsPromotions < ActiveRecord::Migration
  def change
    create_table :discussions_promotions do |t|
      t.references :discussion
      t.references :promotion
    end
    add_index :discussions_promotions, [:promotion_id, :discussion_id]
    add_index :discussions_promotions, :discussion_id
  end
end
