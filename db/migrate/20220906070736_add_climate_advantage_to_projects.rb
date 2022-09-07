class AddClimateAdvantageToProjects < ActiveRecord::Migration[7.0]
  def change
    add_column :projects, :climate_advantage, :text
  end
end
