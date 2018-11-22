class CreateAds < ActiveRecord::Migration[5.2]
  def change
    create_table :ads do |t|
      t.text :ad_link
      t.text :img_link
      t.string :title
      t.string :company_name
      t.references :target_site, null: false
      t.references :target_page, null: false

      t.timestamps
    end
  end
end
