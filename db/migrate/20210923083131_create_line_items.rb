class CreateLineItems < ActiveRecord::Migration[5.0]
  def change
    create_table :line_items do |t|
      t.references :document, foreign_key: true
      t.belongs_to :invoice, foreign_key: true

      t.timestamps
    end
  end
end
