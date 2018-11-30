class Ad < ApplicationRecord
  belongs_to :target_page
  belongs_to :target_site

  validates :target_page, presence: true
  validates :target_site, presence: true
end
