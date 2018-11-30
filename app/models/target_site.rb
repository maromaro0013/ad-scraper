class TargetSite < ApplicationRecord
  has_many :target_page, dependent: :destroy
end
