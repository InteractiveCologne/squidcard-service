class AddAdminToEvent < ActiveRecord::Migration
  def change
    add_column :events, :admin_id, :integer, null: false
    add_index :events, :admin_id
  end
end
