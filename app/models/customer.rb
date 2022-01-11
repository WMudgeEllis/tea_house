class Customer < ApplicationRecord
  has_many :subscriptions
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :address, presence: true

  def cancelled_subscriptions
    subscriptions.where(status: 'cancelled')
  end

  def active_subscriptions
    subscriptions.where(status: 'active')
  end
end
