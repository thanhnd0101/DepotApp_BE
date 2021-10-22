class AddCompletedToCart < ActiveRecord::Migration[5.0]
  def change
    add_column :carts, :completed, :boolean
  end
end
