class DeleteProjectUsers < ActiveRecord::Migration[7.0]
  def change
    drop_table :project_users
  end
end
