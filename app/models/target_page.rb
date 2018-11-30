class TargetPage < ApplicationRecord
  belongs_to :target_site
  has_many :ad, dependent: :destroy
  has_many :target_page_crawl_method, dependent: :destroy
end
