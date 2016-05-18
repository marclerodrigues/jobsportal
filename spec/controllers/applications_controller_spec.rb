require 'rails_helper'

RSpec.describe ApplicationsController, type: :controller do
  describe 'GET #index' do
    let(:application) { FactoryGirl.create(:application)}
    it 'assigns applications as @applications' do
      get :index
      expect(assigns(:applications)).to eq([application])
    end
  end

  describe 'GET #show' do
    before :each do
      @company = FactoryGirl.create(:company)
      @job = FactoryGirl.create(:job, company: @company)
      @candidate = FactoryGirl.create(:candidate)
      @requirement = FactoryGirl.create(:requirement, job: @job)
      @skill = FactoryGirl.create(:skill, candidate: @candidate)
      @application = FactoryGirl.create(:application,
          company_id: @company,
          job_id: @job,
          candidate_id: @candidate
        )
    end

    it 'assigns application as @application' do
      get :show, id: @application
      expect(assigns(:application)).to eq(@application)
    end
    it 'assigs the correct value for match' do
      get :show, id: @application
      expect(assigns(:application).match).to eq(1)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      before :each do
        @company = FactoryGirl.create(:company)
        @job = FactoryGirl.create(:job, company: @company)
        @candidate = FactoryGirl.create(:candidate)
        @requirement = FactoryGirl.create(:requirement, job: @job)
        @skill = FactoryGirl.create(:skill, candidate: @candidate)
        @application = FactoryGirl.attributes_for(:application,
            company_id: @company,
            job_id: @job,
            candidate_id: @candidate
          )
      end

      it 'assigns application as a Application' do
        post :create, application: @application
        expect(assigns(:application)).to be_a(Application)
      end

      it 'return the expected value for match' do
        post :create, application: @application
        expect(assigns(:application).match).to eq(100)
      end

      it 'creates new record' do
        expect {
          post :create, application: @application
        }.to change(Application, :count).by(1)
      end

      it 'redirect to new application' do
        post :create, application: @application
        expect(response).to redirect_to(Application.last)
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @application = FactoryGirl.create(:application)
    end

    it 'deletes the application' do
      expect{
        delete :destroy, id: @application
      }.to change(Application, :count).by(-1)
    end

    it 'redirects to applications path' do
      delete :destroy, id: @application
      expect(response).to redirect_to(applications_path)
    end
  end
end
