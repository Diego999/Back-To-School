class AddProfessorToUsers < ActiveRecord::Migration
  def change
    add_column :users, :professor, :boolean, :default => false, :presence => true
  end
end
