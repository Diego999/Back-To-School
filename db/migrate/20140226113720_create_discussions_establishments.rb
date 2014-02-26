class CreateDiscussionsEstablishments < ActiveRecord::Migration
  def change
    create_table :discussions_establishments do |t|
      t.references :discussion
      t.references :establishment
    end
    add_index :discussions_establishments, [:establishment_id, :discussion_id], :name => 'index_dis_est'
    add_index :discussions_establishments, :discussion_id
  end
end
