class Building < ApplicationRecord
  validates :reference, uniqueness: true
end
