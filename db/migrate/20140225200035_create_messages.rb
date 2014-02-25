class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :text, null: false
      t.references :author, index: true, null: false

      t.timestamps
    end
  end
end
