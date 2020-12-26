class Mission < ApplicationRecord
  belongd_to :user
  has_many :small_goals, dependent: :destroy
  has_many :records , dependent: :destroy
  has_many :time_attacks , dependent: :destroy
end
