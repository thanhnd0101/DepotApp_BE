class CreateUploadMedia < ActiveRecord::Migration[5.0]
  def change
    create_table :upload_media do |t|
      t.string :file_name
      t.string :path
      t.string :media_type
      t.references :document, foreign_key: true

      t.timestamps
    end
  end
end
