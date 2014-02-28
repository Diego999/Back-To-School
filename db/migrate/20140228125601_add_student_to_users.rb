class AddStudentToUsers < ActiveRecord::Migration
  def change
    add_column :users, :student, :boolean, :default => false, :presence => true
  end
end
