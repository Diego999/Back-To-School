class AddEstAdminToUsers < ActiveRecord::Migration
  def change
    add_column :users, :est_admin, :boolean, :default => false, :presence => true
  end
end
