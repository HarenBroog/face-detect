class AddFeatureToCords < ActiveRecord::Migration
  def change
    add_column :cords, :feature, :integer
  end
end
