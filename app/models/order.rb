class Order < ApplicationRecord
  belongs_to :user
  validates :total_price, presence: true, numericality: { greater_than: 0 }
end
