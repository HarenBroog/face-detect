class CreateMeasures < ActiveRecord::Migration
  def change
    create_table :measures do |t|
      t.references :face
      t.timestamps null: false
    end
  end
end
