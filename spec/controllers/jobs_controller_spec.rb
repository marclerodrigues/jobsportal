require 'rails_helper'

RSpec.describe JobsController, type: :controller do
  describe 'GET #index' do
    let(:job) { FactoryGirl.create(:job, company: FactoryGirl.create(:company)) }

    before :each do
      get :index
    end

    it 'returns status 200 OK' do
      expect(response).to be_success
    end

    it 'assigns job as @jobs' do
      expect(assigns(:jobs)).to eq([job])
    end
  end

  describe 'GET #show' do
    let(:job) { FactoryGirl.create(:job, company: FactoryGirl.create(:company)) }

    before :each do
      get :show, id: job
    end

    it 'returns status 200 OK' do
      expect(response).to be_success
    end

    it 'assigns job to @job' do
      expect(assigns(:job)).to eq(job)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      let(:job) { FactoryGirl.attributes_for(:job, company: FactoryGirl.create(:company)) }

      it 'assigns job to @job' do
        post :create, job: job
        expect(assigns(:job)).to be_a(Job)
      end

      it 'creates new record' do
        expect {
          post :create, job: job
        }.to change(Job, :count).by(1)
      end

      it 'redirects to @company' do
        post :create, job: job
        expect(response).to redirect_to Job.last
      end
    end

    context 'with invalid attributes' do
      let(:job) { FactoryGirl.attributes_for(:job, title: nil) }

      it 'does not save job' do
        expect {
          post :create, job: job
        }.not_to change(Job, :count)
      end

      it 're-renders :new template' do
        post :create, job: job
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid attributes' do
      let(:job) { FactoryGirl.create(:job) }

      before :each do
        put :update, id: job, job: FactoryGirl.attributes_for(:job, title: "New")
      end

      it 'assigns the corret job to @job' do
        expect(assigns(:job)).to eq(job)
      end

      it 'changes job attributes' do
        job.reload
        expect(job.title).to eq("New")
      end

      it 'redirect to updated job' do
        expect(response).to redirect_to(job)
      end
    end

    context 'with invalid attributes' do
      let(:job) { FactoryGirl.create(:job) }

      before :each do
        put :update, id: job, job: FactoryGirl.attributes_for(:job, title: nil)
      end

      it 'assigns the correct job to @job' do
        expect(assigns(:job)).to eq(job)
      end

      it 'does not changes job attributes' do
        job.reload
        expect(job.title).to eq("MyText")
      end
      it 're-render :edit template' do
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do

    before :each do
      @job = FactoryGirl.create(:job)
    end

    it 'assigns the correct job to @job' do
      delete :destroy, id: @job
    end

    it 'deletes the job' do
      expect {
        delete :destroy, id: @job
      }.to change(Job, :count).by(-1)
    end

    it 'redirects to jobs path' do
      delete :destroy, id: @job
      expect(response).to redirect_to jobs_path
    end

  end
end
