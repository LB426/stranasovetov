class CreatePublications < ActiveRecord::Migration
  def change
    create_table :publications do |t|
      t.string :title, null: false
      t.text :text, null: false

      t.timestamps
    end
  end
end
