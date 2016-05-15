require 'rails_helper'

RSpec.describe CandidatesController, type: :controller do
  describe 'GET #index' do
    let(:candidate) { FactoryGirl.create(:candidate)}
    before :each do
      get :index
    end

    it 'returns status 200 OK' do
      expect(response).to be_success
    end

    it 'assigns candidates as @candidates' do
      expect(assigns(:candidates)).to eq([candidate])
    end
  end
  describe 'GET #show' do
    let(:candidate) { FactoryGirl.create(:candidate) }

    before :each do
      get :show, id: candidate
    end

    it 'return status 200 OK' do
      expect(response).to be_success
    end

    it 'assigns candidate to @candidate' do
      expect(assigns(:candidate)).to eq(candidate)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      let(:candidate) { FactoryGirl.attributes_for(:candidate) }

      it 'assigns candidate as Candidate' do
        post :create, candidate: candidate
        expect(assigns(:candidate)).to be_a(Candidate)
      end

      it 'creates new record' do
        expect{
          post :create, candidate: candidate
        }.to change(Candidate, :count).by(1)
      end

      it 'redirects to @candidate' do
        post :create, candidate: candidate
        expect(response).to redirect_to Candidate.last
      end
    end

    context 'with invalid attributes' do
      let(:candidate) { FactoryGirl.attributes_for(:candidate, first_name: nil) }

      it 'does not save the candidate' do
        expect {
          post :create, candidate: candidate
        }.not_to change(Candidate, :count)
      end

      it 're-render :new template' do
        post :create, candidate: candidate
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid attributes' do
      let(:candidate) { FactoryGirl.create(:candidate) }

      before :each do
        put :update, id: candidate, candidate: FactoryGirl.attributes_for(:candidate, first_name: "John")
      end

      it 'assigns the correct candidate to @candidate' do
        expect(assigns(:candidate)).to eq(candidate)
      end

      it 'changes candidates attributes' do
        candidate.reload
        expect(candidate.first_name).to eq("John")
      end

      it 'redirects to updated candidate' do
        expect(response).to redirect_to(candidate)
      end
    end

    context 'with invalid attributes' do
      let(:candidate) { FactoryGirl.create(:candidate) }

      before :each do
        put :update, id: candidate, candidate: FactoryGirl.attributes_for(:candidate, first_name: nil)
      end

      it 'does not change candidate attributes' do
        candidate.reload
        expect(candidate.first_name).to eq("MyText")
      end

      it 're-renders :edit template' do
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @candidate = FactoryGirl.create(:candidate)
    end

    it 'assigns the correct candidate to @candidate' do
      delete :destroy, id: @candidate
      expect(assigns(:candidate)).to eq(@candidate)
    end

    it 'deletes the candidate' do
      expect{
        delete :destroy, id: @candidate
      }.to change(Candidate, :count).by(-1)
    end

    it 'redirects to candidates path' do
      delete :destroy, id: @candidate
      expect(response).to redirect_to candidates_path
    end
  end
end
