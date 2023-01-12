class Category < ApplicationRecord
  has_many :discussions, dependent: :destroy

  scope :sorted, -> { order(name: :asc) }
  
end
