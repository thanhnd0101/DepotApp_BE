class AddCompletedToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :completed, :boolean
  end
end
