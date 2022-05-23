class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :vat_number
      t.string :website
      t.text :avatar

      t.timestamps
    end
  end
end
