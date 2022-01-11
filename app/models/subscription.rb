class Subscription < ApplicationRecord
  belongs_to :customer
  has_many :tea_subscriptions
  has_many :teas, through: :tea_subscriptions
  validates :title, presence: true
  validates :frequency, presence: true
  validates :status, presence: true
  validates :price, presence: true

  enum status: [:active, :cancelled]
end
