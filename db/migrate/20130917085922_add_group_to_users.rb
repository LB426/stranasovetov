class AddGroupToUsers < ActiveRecord::Migration
  def change
    add_column :users, :group, :string, :null => false
    add_column :users, :fio, :string
  end
end
