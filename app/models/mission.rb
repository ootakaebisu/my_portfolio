class Mission < ApplicationRecord
  belongs_to :user
  has_many :small_goals, dependent: :destroy
  has_many :records , dependent: :destroy
  has_many :time_attacks , dependent: :destroy
  enum status: { doing: 1, after: 2 }
end
