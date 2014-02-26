class CreateFollowers < ActiveRecord::Migration
  def change
    create_table :followers do |t|
      t.boolean :accepted

      t.timestamps
    end
  end
end
