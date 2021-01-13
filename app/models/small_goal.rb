class SmallGoal < ApplicationRecord
  belongs_to :mission
  enum status: { before: 0, doing: 1, after: 2 }

  include RankedModel
  ranks :row_order , with_same: :mission_id
end
