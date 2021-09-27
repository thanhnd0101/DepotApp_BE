class AddOrderToLineItem < ActiveRecord::Migration[5.0]
  def change
    add_reference :line_items, :order, foreign_key: true
    change_column :line_items, :cart_id, :integer, null: true
  end
end
