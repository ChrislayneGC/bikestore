class AddComplementToAdress < ActiveRecord::Migration
  def change
    add_column :addresses, :complement, :string
  end
end
