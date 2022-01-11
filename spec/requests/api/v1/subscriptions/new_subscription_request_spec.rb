require "rails_helper"

RSpec.describe 'new subscription request' do
  before :each do
    @customer = create(:customer)
    @tea = create(:tea)
    create_list(:tea, 5)
  end

  it 'can create a subscription' do
    data = {
      customer_id: @customer.id,
      tea_ids: [@tea.id],
      title: 'best subscription ever',
      price: 1800,
      frequency: 7
    }
    post '/api/v1/subscriptions', params: data

    expect(response).to be_successful

    response = JSON.parse(response.body, sybolize_names: true)

    expect(response).to have_key(:data)
    expect(response[:data]).to be_a(Hash)
    expect(response[:data]).to have_key(:id)
    expect(response[:data][:id]).to be_a(Integer)
    expect(response[:data]).to have_key(:type)
    expect(response[:data][:type]).to be_a(String)
    expect(response[:data]).to have_key(:attributes)
    expect(response[:data][:attributes]).to be_a(Hash)
    expect(response[:data]).to have_key(:teas)
    expect(response[:data][:teas]).to be_a(Array)
  end
end
