class TargetPageCrawlMethod < ApplicationRecord
  belongs_to :target_page
  belongs_to :crawl_method
end
