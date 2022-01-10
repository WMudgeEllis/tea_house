require "rails_helper"

RSpec.describe Subscription do
  describe 'validations' do

  end

  describe 'relationships' do
    it { should belong_to(:customer) }
    it { should have_many(:tea_subscriptions) }
    it { should have_many(:teas).through(:tea_subscriptions)}
  end
end
