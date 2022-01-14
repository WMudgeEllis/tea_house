require "rails_helper"

RSpec.describe 'new subscription request' do
  before :each do
    @customer = create(:customer)
    @tea = create(:tea)
    create_list(:tea, 5)
  end

  it 'can create a subscription with a string' do
    data = {
      customer_id: @customer.id,
      tea_ids: "[#{@tea.id}]",
      title: 'best subscription ever',
      price: 1800,
      frequency: 7
    }
    post '/api/v1/subscriptions', params: data

    expect(response).to be_successful

    body = JSON.parse(response.body, symbolize_names: true)

    expect(body).to have_key(:data)
    expect(body[:data]).to be_a(Hash)
    expect(body[:data]).to have_key(:id)
    expect(body[:data][:id]).to be_a(Integer)
    expect(body[:data]).to have_key(:type)
    expect(body[:data][:type]).to be_a(String)
    expect(body[:data]).to have_key(:attributes)
    expect(body[:data][:attributes]).to be_a(Hash)
    expect(body[:data]).to have_key(:teas)
    expect(body[:data][:teas]).to be_a(Array)
  end

  it 'can create a subsctriction with an array' do
    data = {
      customer_id: @customer.id,
      tea_ids: [@tea.id],
      title: 'best subscription ever',
      price: 1800,
      frequency: 7
    }
    post '/api/v1/subscriptions', params: data

    expect(response).to be_successful

    body = JSON.parse(response.body, symbolize_names: true)

    expect(body).to have_key(:data)
    expect(body[:data]).to be_a(Hash)
    expect(body[:data]).to have_key(:id)
  end

  it 'returns errors with missing params' do
    data = {
      title: 'best subscription ever'
    }

    post '/api/v1/subscriptions', params: data

    expect(response).to_not be_successful

    body = JSON.parse(response.body, symbolize_names: true)

    expect(body).to have_key(:errors)
  end
end
