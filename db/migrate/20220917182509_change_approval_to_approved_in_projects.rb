class ChangeApprovalToApprovedInProjects < ActiveRecord::Migration[7.0]
  def change
    rename_column :projects, :approval, :approved
  end
end
