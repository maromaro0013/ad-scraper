class TargetPage < ApplicationRecord
  belongs_to :target_site
  has_many :ad, dependent: :destroy
end
