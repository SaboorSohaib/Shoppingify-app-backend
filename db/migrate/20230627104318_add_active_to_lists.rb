class AddActiveToLists < ActiveRecord::Migration[7.0]
  def change
    add_column :lists, :active, :boolean
  end
end
