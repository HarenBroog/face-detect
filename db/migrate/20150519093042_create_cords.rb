class CreateCords < ActiveRecord::Migration
  def change
    create_table :cords do |t|
      t.float      :x
      t.float      :y
      t.references :measure
      t.timestamps null: false
    end
  end
end
