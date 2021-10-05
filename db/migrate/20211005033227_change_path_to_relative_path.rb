class ChangePathToRelativePath < ActiveRecord::Migration[5.0]
  def change
    rename_column :upload_media, :path, :relative_path
  end
end
