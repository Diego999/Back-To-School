class CreateDiscussions < ActiveRecord::Migration
  def change
    create_table :discussions do |t|
      t.string :title, null: false

      t.timestamps
    end
  end
end
