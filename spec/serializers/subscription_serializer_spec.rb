require "rails_helper"

RSpec.describe SubscriptionSerializer do
  before :each do
    @customer = create(:customer)
    @subscription = create(:subscription, customer_id: @customer.id)
    teas = create_list(:tea, 5)
    tea_ids = teas.map { |tea| tea.id }
    tea_ids.each { |tea_id| TeaSubscription.create!(tea_id: tea_id, subscription_id: @subscription.id) }
  end

  it '#new_subscription' do
    result = SubscriptionSerializer.new_subscription(@subscription, @subscription.teas)

    expect(result[:data][:id]).to eq(@subscription.id)
    expect(result[:data][:type]).to eq('subscription')
    expect(result[:data][:attributes]).to be_a(Hash)

    attributes = result[:data][:attributes]

    expect(attributes[:title]).to eq(@subscription.title)
    expect(attributes[:price]).to eq(@subscription.price)
    expect(attributes[:frequency]).to eq(@subscription.frequency)
    expect(attributes[:status]).to eq(@subscription.status)

    expect(result[:data][:teas]).to be_a(Array)
    expect(result[:data][:teas].length).to eq(5)
  end

  it '#subscription_show' do
    result = SubscriptionSerializer.subscription_show(@subscription)

    expect(result[:data][:id]).to eq(@subscription.id)
    expect(result[:data][:type]).to eq('subscription')
    expect(result[:data][:attributes]).to be_a(Hash)

    attributes = result[:data][:attributes]

    expect(attributes[:title]).to eq(@subscription.title)
    expect(attributes[:price]).to eq(@subscription.price)
    expect(attributes[:frequency]).to eq(@subscription.frequency)
    expect(attributes[:status]).to eq(@subscription.status)
  end
end
