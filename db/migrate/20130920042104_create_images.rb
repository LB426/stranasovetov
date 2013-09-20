class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.integer :user_id
      t.integer :publication_id
      t.text :description

      t.timestamps
    end
  end
end
