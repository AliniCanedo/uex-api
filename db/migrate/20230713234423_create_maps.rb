class CreateMaps < ActiveRecord::Migration[7.0]
  def change
    create_table :maps do |t|

      t.references :address, null: false, foreign_key: true
      t.decimal :latitude, precision: 10, scale: 6
      t.decimal :longitude, precision: 10, scale: 6

      t.timestamps

    end
  end
end
