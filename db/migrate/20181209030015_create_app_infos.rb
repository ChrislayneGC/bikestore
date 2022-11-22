class CreateAppInfos < ActiveRecord::Migration
  def change
    create_table :app_infos do |t|
      t.string :bio_title
      t.string :bio 
      t.string :email 
      t.string :facebook
      t.string :instagram
      t.string :whatsapp
      t.timestamps null: false
    end
  end
end
