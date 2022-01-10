require "rails_helper"

RSpec.describe TeaSubscription do
  describe 'validations' do

  end

  describe 'relationships' do
    it { should belong_to(:subscription) }
    it { should belong_to(:tea) }
  end
end
