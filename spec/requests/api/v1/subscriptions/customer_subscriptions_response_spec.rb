require "rails_helper"

RSpec.describe 'customer subscriptions request' do
  before :each do
    @customer = create(:customer)
    @subscription1 = create(:subscription, customer: @customer, status: 'active')
    @subscription2 = create(:subscription, customer: @customer, status: 'cancelled')
  end

  it 'can get all of a customers subscriptions' do
    get "/api/v1/customers/#{@customer.id}/subscriptions"

    expect(response).to be_successful

    body = JSON.parse(response.body, symbolize_names: true)

    expect(body).to have_key(:data)
    expect(body[:data]).to have_key(:cancelled_subscriptions)
    expect(body[:data]).to have_key(:active_subscriptions)
    expect(body[:data][:active_subscriptions]).to be_a(Array)
    expect(body[:data][:active_subscriptions].length).to eq(1)
    expect(body[:data][:cancelled_subscriptions]).to be_a(Array)
    expect(body[:data][:cancelled_subscriptions].length).to eq(1)
  end
end
