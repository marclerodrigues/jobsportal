require 'rails_helper'

RSpec.describe CompaniesController, type: :controller do
  describe 'GET #index' do

    let(:company) { FactoryGirl.create(:company) }

    before :each do
      get :index
    end

    it 'returns status 200 OK' do
      expect(response).to be_success
    end

    it 'assigns companies as @companies' do
      expect(assigns(:companies)).to eq([company])
    end
  end

  describe 'GET #show' do

    let(:company) { FactoryGirl.create(:company) }

    before :each do
      get :show, id: company
    end

    it 'return status 200 OK' do
      expect(response).to be_success
    end

    it 'assigns company to @company' do
      expect(assigns(:company)).to eq(company)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      let(:company) { FactoryGirl.attributes_for(:company) }

      it 'assigns company as a Company' do
        post :create, company: company
        expect(assigns(:company)).to be_a(Company)
      end

      it 'creates a new record' do
        expect{
          post :create, company: company
        }.to change(Company, :count).by(1)
      end

      it 'redirects to @company' do
        post :create, company: company
        expect(response).to redirect_to Company.last
      end
    end

    context 'with invalid attributes' do
      let(:company) { FactoryGirl.attributes_for(:company, name: nil) }

      it 'does not saves the company' do
        expect {
          post :create, company: company
        }.not_to change(Company, :count)
      end

      it 're-renders :new template' do
        post :create, company: company
        expect(response).to render_template :new
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid attributes' do
      let(:company) { FactoryGirl.create(:company) }

      before :each do
        put :update, id: company, company: FactoryGirl.attributes_for(:company, name: "New")
      end

      it 'assigns the correct company to @company' do
        expect(assigns(:company)).to eq(company)
      end

      it 'changes company attributes' do
        company.reload
        expect(company.name).to eq("New")
      end

      it 'redirects to updated company' do
        expect(response).to redirect_to(company)
      end
    end
    context 'with invalid attributes' do
      let(:company) { FactoryGirl.create(:company) }

      before :each do
        put :update, id: company, company: FactoryGirl.attributes_for(:company, name: nil)
      end

      it 'assigns the correct company to @company' do
        expect(assigns(:company)).to eq(company)
      end

      it 'does not changes company attributes' do
        company.reload
        expect(company.name).to eq("MyText")
      end

      it 're-renders :edit template' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @company = FactoryGirl.create(:company)
    end

    it 'assigns the correct company to @company' do
      delete :destroy, id: @company
      expect(assigns(:company)).to eq(@company)
    end

    it 'deletes the company' do
      expect{
        delete :destroy, id: @company
      }.to change(Company, :count).by(-1)
    end

    it 'redirects to companies path' do
      delete :destroy, id: @company
      expect(response).to redirect_to companies_path
    end
  end
end
