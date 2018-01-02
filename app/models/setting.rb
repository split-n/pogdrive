class Setting < ApplicationRecord
  validates_uniqueness_of :name
end
