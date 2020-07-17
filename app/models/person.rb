class Person < ApplicationRecord
  validates :reference, uniqueness: true
end
