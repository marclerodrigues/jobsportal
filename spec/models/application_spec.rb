require 'rails_helper'

RSpec.describe Application, type: :model do
  
  let(:company) { FactoryGirl.create(:company) }
  let(:candidate) { FactoryGirl.create(:candidate) }
  let(:job) { FactoryGirl.create(:job, company: company)}
  let(:application) { FactoryGirl.build(:application,
      candidate: candidate,
      company: company,
      job: job
    )}

  it { is_expected.to belong_to(:candidate) }
  it { is_expected.to belong_to(:company) }
  it { is_expected.to belong_to(:job) }

  it 'has a valid factory' do
    expect(application).to be_valid
  end
end
