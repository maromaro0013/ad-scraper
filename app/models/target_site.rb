class TargetSite < ApplicationRecord
  has_many :target_page, dependent: :destroy
  has_many :ad, dependent: :destroy
end
