class AddPublishToDocument < ActiveRecord::Migration[5.0]
  def change
    add_column :documents, :publish, :boolean
  end
end
