class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.references :face
      t.text       :cords
      t.timestamps null: false
    end
  end
end
