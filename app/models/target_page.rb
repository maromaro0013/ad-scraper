class TargetPage < ApplicationRecord
  belongs_to :target_site
  has_many :ad, dependent: :destroy
  has_many :target_page_crawl_method, dependent: :destroy
  has_many :crawl_methods, through: :target_page_crawl_method

  def crawl
    self.target_page_crawl_method.each { |page_crawl_method|
      method = page_crawl_method.crawl_method
      method.name.classify.constantize.crawl(self)
    }
  end

  def add_crawl_method(crawl_method_id)
    TargetPageCrawlMethod.find_or_create_by(target_page_id: self.id, crawl_method_id: crawl_method_id)
  end
end
