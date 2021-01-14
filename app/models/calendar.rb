class Calendar < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
#   validates :end_date, presence: true
end
