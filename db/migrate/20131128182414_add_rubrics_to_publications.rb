class AddRubricsToPublications < ActiveRecord::Migration
  def change
    add_column :publications, :rubrics, :text
  end
end
