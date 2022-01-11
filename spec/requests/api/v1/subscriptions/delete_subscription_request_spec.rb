require "rails_helper"

RSpec.describe 'delete subscription request' do
  before :each do
    customer = create(:customer)
    @subscription = create(:subscription, customer_id: customer.id)
  end

  it 'can cancel a subscription' do
    patch "/api/v1/subscriptions/#{@subscription.id}", params: { status: 'cancelled' }

    expect(response.status).to eq(200)

    body = JSON.parse(response.body, symbolize_names: true)

    expect(body).to have_key(:data)
    expect(body[:data]).to be_a(Hash)
    expect(body[:data]).to have_key(:id)
    expect(body[:data][:id]).to be_a(Integer)
    expect(body[:data]).to have_key(:type)
    expect(body[:data][:type]).to be_a(String)
    expect(body[:data]).to have_key(:attributes)
    expect(body[:data][:attributes]).to be_a(Hash)
  end
end
