class AddApprovalToProjects < ActiveRecord::Migration[7.0]
  def change
    add_column :projects, :approval, :boolean
  end
end
