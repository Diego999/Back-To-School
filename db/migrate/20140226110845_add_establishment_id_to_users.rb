class AddEstablishmentIdToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :establishment, index: true
  end
end
