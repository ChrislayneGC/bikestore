class AddBilletUrlToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :billet_url, :string
  end
end
