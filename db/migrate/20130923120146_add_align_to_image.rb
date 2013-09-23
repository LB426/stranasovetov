class AddAlignToImage < ActiveRecord::Migration
  def change
    add_column :images, :align, :string
  end
end
