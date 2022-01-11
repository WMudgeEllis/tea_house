require "rails_helper"

RSpec.describe SubscriptionSerializer do
  before :each do
    @customer = create(:customer)
    @subscription = create(:subscription, customer_id: @customer.id)
    @subscription2 = create(:subscription, customer_id: @customer.id, status: 'cancelled')
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

  it '#subscription_index' do
    result = SubscriptionSerializer.subscription_index([@subscription], [@subscription2])

    expect(result).to have_key(:data)
    expect(result[:data]).to have_key(:active_subscriptions)
    expect(result[:data]).to have_key(:cancelled_subscriptions)
    expect(result[:data][:active_subscriptions].length).to eq(1)
    expect(result[:data][:cancelled_subscriptions].length).to eq(1)
    active = result[:data][:active_subscriptions].first
    cancelled = result[:data][:cancelled_subscriptions].first

    expect(active[:attributes][:title]).to eq(@subscription.title)
    expect(active[:attributes][:price]).to eq(@subscription.price)
    expect(active[:attributes][:frequency]).to eq(@subscription.frequency)
    expect(active[:attributes][:status]).to eq(@subscription.status)

    expect(cancelled[:attributes][:title]).to eq(@subscription2.title)
    expect(cancelled[:attributes][:price]).to eq(@subscription2.price)
    expect(cancelled[:attributes][:frequency]).to eq(@subscription2.frequency)
    expect(cancelled[:attributes][:status]).to eq(@subscription2.status)
  end
end
