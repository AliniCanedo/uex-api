class CreateMaps < ActiveRecord::Migration[7.0]
  def change
    create_table :maps do |t|
      t.references :address, null: false, foreign_key: true
      t.decimal :latitude
      t.decimal :longitude

      t.timestamps
    end
  end
end
