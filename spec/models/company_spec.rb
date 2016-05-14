require 'rails_helper'

RSpec.describe Company, type: :model do
  let(:company) { FactoryGirl.create(:company)}

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:about) }

  it 'has a valid factory' do
    expect(company).to be_valid
  end
end
