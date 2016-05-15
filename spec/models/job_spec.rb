require 'rails_helper'

RSpec.describe Job, type: :model do
  let(:company) { FactoryGirl.create(:company) }
  let(:job) { FactoryGirl.create(:job, company: company) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:salary) }
  it { is_expected.to validate_presence_of(:type) }
  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to validate_presence_of(:about) }
  it { is_expected.to belong_to(:company)}

  it 'has a valid factory' do
    expect(job).to be_valid
  end
end
