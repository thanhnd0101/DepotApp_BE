class ChangeToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :email, :string
    add_column :users, :address, :string
  end
end
