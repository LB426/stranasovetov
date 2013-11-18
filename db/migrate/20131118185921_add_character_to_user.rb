class AddCharacterToUser < ActiveRecord::Migration
  def change
    add_column :users, :characterization, :text
  end
end
