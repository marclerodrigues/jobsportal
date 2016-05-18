require 'rails_helper'

RSpec.describe Application, type: :model do
  let(:application) { FactoryGirl.create(:application) }

  it { is_expected.to belong_to(:candidate) }
  it { is_expected.to belong_to(:company) }
  it { is_expected.to belong_to(:job) }

  it 'has a valid factory' do
    expect(application).to be_valid
  end

  context 'candidate_match' do
    before :each do
      @company = FactoryGirl.create(:company)
      @candidate = FactoryGirl.create(:candidate)
      @job = FactoryGirl.create(:job, company: @company)
    end
    it 'returns 50' do
      @requirement = FactoryGirl.create(:requirement, job: @job, title: 'Ruby', years: 5)
      @skill = FactoryGirl.create(:skill, candidate: @candidate, title: 'ruby', years: 2.5)
      match = application.calculate_match(@job, @candidate)
      expect(match).to eq(50)
    end
    it 'returns 75' do
      @requirement = FactoryGirl.create(:requirement, job: @job, title: 'Ruby', years: 5)
      @requirement_2 = FactoryGirl.create(:requirement, job: @job, title: 'Rails', years: 5)
      @skill = FactoryGirl.create(:skill, candidate: @candidate, title: 'ruby', years: 2.5)
      @skill_2 = FactoryGirl.create(:skill, candidate: @candidate, title: 'rails', years: 5)
      match = application.calculate_match(@job, @candidate)
      expect(match).to eq(75)
    end

    it 'returns 0' do
      @requirement = FactoryGirl.create(:requirement, job: @job, title: 'Ruby', years: 5)
      @skill = FactoryGirl.create(:skill, candidate: @candidate, title: 'Rails', years: 2.5)
      match = application.calculate_match(@job, @candidate)
      expect(match).to eq(0)
    end
  end


end
