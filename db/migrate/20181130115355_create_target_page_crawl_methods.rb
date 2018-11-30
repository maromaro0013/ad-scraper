class CreateTargetPageCrawlMethods < ActiveRecord::Migration[5.2]
  def change
    create_table :target_page_crawl_methods do |t|
      t.references :target_page, null: false, foreign_key: true
      t.references :crawl_method, null: false, foreign_key: true

      t.timestamps
    end
  end
end
