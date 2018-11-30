class CrawlMethod < ApplicationRecord
  has_many :target_page_crawl_method, dependent: :destroy
end
