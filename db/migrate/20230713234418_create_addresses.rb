class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.references :contact, null: false, foreign_key: true
      t.string :uf
      t.string :city
      t.string :street
      t.string :cep
      t.string :complement
      t.string :number

      t.timestamps
    end
  end
end
