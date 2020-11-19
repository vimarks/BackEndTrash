class RenameTitleToTrashTitle < ActiveRecord::Migration[6.0]
  def change
    rename_column :images, :type, :image_type
  end
end
