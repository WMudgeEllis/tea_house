require "rails_helper"


RSpec.describe Tea do
  describe 'validations' do

  end

  describe 'relationships' do
    it { should have_many(:tea_subscriptions) }
    it { should have_many(:subscriptions).through(:tea_subscriptions) }
  end
end
