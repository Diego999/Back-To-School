class AddEstablishmentIdToPromotions < ActiveRecord::Migration
  def change
    add_reference :promotions, :establishment, index: true
  end
end
