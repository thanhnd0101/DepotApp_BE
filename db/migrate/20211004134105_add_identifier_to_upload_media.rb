class AddIdentifierToUploadMedia < ActiveRecord::Migration[5.0]
  def change
    add_column :upload_media, :identifier, :string
  end
end
