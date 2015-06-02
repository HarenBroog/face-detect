class ChangeCords < ActiveRecord::Migration
  def change
    remove_column :cords, :x
    remove_column :cords, :y
    remove_column :cords, :feature

    add_column :cords, :p1, :integer
    add_column :cords, :p2, :integer
    add_column :cords, :length, :float
  end
end
