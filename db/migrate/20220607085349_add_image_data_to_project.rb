class AddImageDataToProject < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :image_data, :text
  end
end
