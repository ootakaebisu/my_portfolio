class DailyClear < ApplicationRecord
  belongs_to :mission
  enum status: { unclear: 0, clear: 1 }
end
