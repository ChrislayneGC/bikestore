class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.references :user, index: true, foreign_key: true
      t.string :agency
      t.string :account
      t.string :bank
      t.string :name
      t.string :identifier
      t.boolean :active
      t.string :code
      t.string  :slug, index: true
      t.timestamps null: false
    end
  end
end
