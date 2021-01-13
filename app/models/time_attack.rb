class TimeAttack < ApplicationRecord
  belongs_to :mission
  enum status: { before: 0, doing: 1, after: 2 }

  validates :deadline_at, presence: true
end
