class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :firstname
      t.string :lastname
      t.string :mail
      t.string :password
      t.string :salt

      t.timestamps
    end
  end
end
