require 'rails_helper'

RSpec.describe Address, type: :model do

  let(:address) { FactoryGirl.build(:address) }

  it { is_expected.to validate_presence_of(:street) }
  it { is_expected.to validate_presence_of(:city) }
  it { is_expected.to validate_presence_of(:state) }

  it 'has a valid factory' do
    expect(address).to be_valid
  end
end
