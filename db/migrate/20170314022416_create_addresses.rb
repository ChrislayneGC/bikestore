class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.references :user, index: true, foreign_key: true
      t.string :kind, default: 'home'
      t.string :street
      t.string :district
      t.string :number
      t.string :zipcode
      t.string :city
      t.string :state
      t.string :country, default: 'Brasil'
      t.float :latitude
      t.float :longitude
      t.boolean :active
      t.timestamps null: false
    end
  end
end
