class AddImageDataToCompany < ActiveRecord::Migration[6.1]
  def change
    add_column :companies, :image_data, :text
  end
end
