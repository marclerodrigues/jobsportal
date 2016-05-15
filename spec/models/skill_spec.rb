require 'rails_helper'

RSpec.describe Skill, type: :model do
  let(:skill) { FactoryGirl.build(:skill, candidate: FactoryGirl.create(:candidate))}

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:years) }
  it { is_expected.to belong_to(:candidate) }

  it 'has a valid factory' do
    expect(skill).to be_valid
  end
end
