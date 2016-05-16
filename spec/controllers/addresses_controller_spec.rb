require 'rails_helper'

RSpec.describe AddressesController, type: :controller do
  describe 'GET #index' do
    let(:address) { FactoryGirl.create(:address) }

    before :each do
      get :index
    end

    it 'assigns address to @addresses' do
      expect(assigns(:addresses)).to eq([address])
    end
  end

  describe 'GET #show' do
    let(:address) { FactoryGirl.create(:address) }

    before :each do
      get :show, id: address
    end

    it 'assigns address to @address' do
      expect(assigns(:address)).to eq(address)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      let(:address) { FactoryGirl.attributes_for(:address) }

      it 'assigns address as Address' do
        post :create, address: address
        expect(assigns(:address)).to be_a(Address)
      end

      it 'creates a new record' do
        expect{
          post :create, address: address
        }.to change(Address, :count).by(1)
      end

      it 'redirects to @address' do
        post :create, address: address
        expect(response).to redirect_to(Address.last)
      end
    end

    context 'with invalid attributes' do
      let(:address) { FactoryGirl.attributes_for(:address, street: nil) }

      it 'does not save the address' do
        expect{
          post :create, address: address
        }.not_to change(Address, :count)
      end

      it 're-renders :new template' do
        post :create, address: address
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid attributes' do
      let(:address) { FactoryGirl.create(:address) }

      before :each do
        put :update, id: address, address: FactoryGirl.attributes_for(:address, street:"New")
      end

      it 'assigns the correct address to @address' do
        expect(assigns(:address)).to eq(address)
      end

      it 'changes address attributes' do
        address.reload
        expect(address.street).to eq("New")
      end

      it 'redirects to updated address' do
        expect(response).to redirect_to(address)
      end
    end

    context 'with invalid attributes' do
      let(:address) { FactoryGirl.create(:address) }

      before :each do
        put :update, id: address, address: FactoryGirl.attributes_for(:address, street: nil)
      end

      it 'does not change address attributes' do
        address.reload
        expect(address.street).to eq("MyText")
      end

      it 're-renders :edit template' do
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @address = FactoryGirl.create(:address)
    end

    it 'assigns the correct address to @address' do
      delete :destroy, id: @address
      expect(assigns(:address)).to eq(@address)
    end

    it 'deletes the record' do
      expect{
        delete :destroy, id: @address
      }.to change(Address, :count).by(-1)
    end

    it 'redirects to addresses path' do
      delete :destroy, id: @address
      expect(response).to redirect_to addresses_path
    end
  end
end
