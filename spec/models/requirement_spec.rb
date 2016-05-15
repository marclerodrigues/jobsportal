require 'rails_helper'

RSpec.describe Requirement, type: :model do

  let(:job) { FactoryGirl.create(:job, company: FactoryGirl.create(:company)) }
  let(:requirement) { FactoryGirl.build(:requirement, job: job)}

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:years) }
  it { is_expected.to belong_to(:job) }

  it 'has a valid factory' do
    expect(job).to be_valid
  end

end
