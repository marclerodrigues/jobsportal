require 'rails_helper'

RSpec.describe RequirementsController, type: :controller do
  describe 'GET #index' do
    let(:requirement) { FactoryGirl.create(:requirement, job: FactoryGirl.create(:job)) }

    before :each do
      get :index
    end

    it 'returns status 200 OK' do
      expect(response).to be_success
    end

    it 'assigns requirements as @requirements' do
      expect(assigns(:requirements)).to eq([requirement])
    end
  end

  describe 'GET #show' do
    let(:requirement) { FactoryGirl.create(:requirement, job: FactoryGirl.create(:job)) }

    before :each do
      get :show, id: requirement
    end

    it 'return status 200 OK' do
      expect(response).to be_success
    end

    it 'assigns requirement as @requirement' do
      expect(assigns(:requirement)).to eq(requirement)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      let(:requirement) { FactoryGirl.attributes_for(:requirement, job: FactoryGirl.create(:job)) }

      it 'assigns requirement to @requirement' do
        post :create, requirement: requirement
        expect(assigns(:requirement)).to be_a(Requirement)
      end

      it 'creates new record' do
        expect{
          post :create, requirement: requirement
        }.to change(Requirement, :count).by(1)
      end

      it 'redirects to @requirement' do
        post :create, requirement: requirement
        expect(response).to redirect_to Requirement.last
      end
    end

    context 'with invalid attributes' do
      let(:requirement) { FactoryGirl.attributes_for(:requirement, title: nil, job: FactoryGirl.create(:job)) }

      it 'does not save the requirement' do
        expect{
          post :create, requirement: requirement
        }.not_to change(Requirement, :count)
      end

      it 're-renders :new template' do
        post :create, requirement: requirement
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid attributes' do
      let(:requirement) { FactoryGirl.create(:requirement) }

      before :each do
        put :update, id: requirement, requirement: FactoryGirl.attributes_for(:requirement, years: 12)
      end

      it 'assigns the correct requirement to @requirement' do
        expect(assigns(:requirement)).to eq(requirement)
      end

      it 'changes requirement attributes' do
        requirement.reload
        expect(requirement.years).to eq(12)
      end

      it 'redirect to updated requirement' do
        expect(response).to redirect_to(requirement)
      end
    end
  end
  context 'with invalid attributes' do
    let(:requirement) { FactoryGirl.create(:requirement) }

    before :each do
      put :update, id: requirement, requirement: FactoryGirl.attributes_for(:requirement, title: nil)
    end

    it 'does not change requirement attributes' do
      requirement.reload
      expect(requirement.title).to eq("MyText")
    end

    it 're-render :edit template' do
      expect(response).to render_template(:edit)
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @requirement = FactoryGirl.create(:requirement)
    end

    it 'assigns the correct requirement to @requirement' do
      delete :destroy, id: @requirement
      expect(assigns(:requirement)).to eq(@requirement)
    end

    it 'delete the requirement' do
      expect {
        delete :destroy, id: @requirement
      }.to change(Requirement, :count).by(-1)
    end

    it 'redirects to requirements path' do
      delete :destroy, id: @requirement
      expect(response).to redirect_to requirements_path
    end
  end
end
