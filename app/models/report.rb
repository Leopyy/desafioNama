class Report < ApplicationRecord
  has_one_attached :file
  has_many :items, dependent: :destroy

  validates :file, attached: true, content_type: 'text'
end
