class DeleteUserIdFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :company_id
  end
end
