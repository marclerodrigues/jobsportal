require 'rails_helper'

RSpec.describe Candidate, type: :model do

  let(:candidate) { FactoryGirl.create(:candidate) }
  
  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }

  it 'has a valid factory' do
    expect(candidate).to be_valid
  end
end
