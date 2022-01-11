require "rails_helper"


RSpec.describe Customer do
  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:address) }
  end

  describe 'relationships' do
    it { should have_many(:subscriptions) }
  end

  describe 'instance methods' do
    before :each do
      @customer = create(:customer)
      @subscription1 = create(:subscription, customer: @customer, status: 'active')
      @subscription2 = create(:subscription, customer: @customer, status: 'cancelled')
    end

    it '#cancelled_subscriptions' do
      result = @customer.cancelled_subscriptions

      expect(result).to eq([@subscription2])
    end

    it '#active_subscriptions' do
      result = @customer.active_subscriptions
      expect(result).to eq([@subscription1])
    end
  end
end
