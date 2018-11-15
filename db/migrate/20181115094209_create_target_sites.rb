class CreateTargetSites < ActiveRecord::Migration[5.2]
  def change
    create_table :target_sites do |t|
      t.string :name, null: false
      t.string :domain, null: false

      t.timestamps
    end
  end
end
