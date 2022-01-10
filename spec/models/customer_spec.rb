require "rails_helper"


RSpec.describe Customer do
  describe 'validations' do

  end

  describe 'relationships' do
    it { should have_many(:subscriptions) }
  end
end
