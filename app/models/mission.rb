class Mission < ApplicationRecord
  belongs_to :user
  has_many :small_goals, dependent: :destroy
  has_many :records , dependent: :destroy
  has_many :time_attacks , dependent: :destroy
  has_many :daily_clears , dependent: :destroy
  enum status: { doing: 1, after: 2 }

  validates :title, presence: true, length: {maximum: 100}
  validates :record_title, presence: true, length: {maximum: 100}
end
