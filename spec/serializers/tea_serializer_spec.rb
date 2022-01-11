require "rails_helper"

RSpec.describe TeaSerializer do
  before :each do
    @tea = create(:tea)
  end

  it '#tea_show' do
    result = TeaSerializer.tea_show(@tea)

    expect(result[:id]).to eq(@tea.id)
    expect(result[:type]).to eq('tea')
    expect(result[:attributes][:title]).to eq(@tea.title)
    expect(result[:attributes][:description]).to eq(@tea.description)
    expect(result[:attributes][:temperature]).to eq(@tea.temperature)
    expect(result[:attributes][:brew_time]).to eq(@tea.brew_time)
  end
end
