class ChangeFromOrder < ActiveRecord::Migration[5.0]
  def change
    remove_column :orders, :completed
    add_column :orders, :total_price, :decimal
  end
end
