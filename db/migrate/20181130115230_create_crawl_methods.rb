class CreateCrawlMethods < ActiveRecord::Migration[5.2]
  def change
    create_table :crawl_methods do |t|
      t.string :name, null: false, default: ""

      t.timestamps
    end
  end
end
