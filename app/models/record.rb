class Record < ApplicationRecord
  belongs_to :mission
  validates :title, presence: true, length: {maximum: 100}
end
