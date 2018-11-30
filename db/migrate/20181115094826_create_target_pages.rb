class CreateTargetPages < ActiveRecord::Migration[5.2]
  def change
    create_table :target_pages do |t|
      t.string :name, null: false
      t.string :uri, null: false
      t.references :target_site, null: false, foreign_key: true

      t.timestamps
    end
  end
end
