require 'rails_helper'

RSpec.describe SkillsController, type: :controller do
  describe 'GET #index' do
    let(:skill)  { FactoryGirl.create(:skill) }

    before :each do
      get :index
    end

    it 'return status 200 OK' do
      expect(response).to be_success
    end

    it 'assigns skills to @skills' do
      expect(assigns(:skills)).to eq([skill])
    end
  end

  describe 'GET #show' do
    let(:skill) { FactoryGirl.create(:skill) }

    before :each do
      get :show, id: skill
    end

    it 'assigns skill to @skill' do
      expect(assigns(:skill)).to eq(skill)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      let(:skill) { FactoryGirl.attributes_for(:skill) }

      it 'assigns skill as Skill' do
        post :create, skill: skill
        expect(assigns(:skill)).to be_a(Skill)
      end

      it 'creates a new record' do
        expect{
          post :create, skill: skill
        }.to change(Skill, :count).by(1)
      end

      it 'redirect to @skill' do
        post :create, skill: skill
        expect(response).to redirect_to(Skill.last)
      end
    end

    context 'with invalid attributes' do
      let(:skill) { FactoryGirl.attributes_for(:skill, title: nil) }

      it 'does not save the skill' do
        expect{
          post :create, skill: skill
        }.not_to change(Skill, :count)
      end

      it 're-renders :new template' do
        post :create, skill: skill
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid attributes' do
      let(:skill) { FactoryGirl.create(:skill) }

      before :each do
        put :update, id: skill, skill: FactoryGirl.attributes_for(:skill, title: "New")
      end

      it 'assigns the correct skill to @skill' do
        expect(assigns(:skill)).to eq(skill)
      end

      it 'changes skill attributes' do
        skill.reload
        expect(skill.title).to eq("New")
      end

      it 'redirects to updated skill' do
        expect(response).to redirect_to(skill)
      end
    end

    context 'with invalid attributes' do
      let(:skill) { FactoryGirl.create(:skill) }

      before :each do
        put :update, id: skill, skill: FactoryGirl.attributes_for(:skill, title: nil)
      end

      it 'does not change skill attributes' do
        skill.reload
        expect(skill.title).to eq("MyText")
      end

      it 're-render :edit template' do
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @skill = FactoryGirl.create(:skill)
    end

    it 'assigns the correct skill to @skill' do
      delete :destroy, id: @skill
      expect(assigns(:skill)).to eq(@skill)
    end

    it 'deletes the skill' do
      expect {
        delete :destroy, id: @skill
      }.to change(Skill, :count).by(-1)
    end

    it 'redirects to skills path' do
      delete :destroy, id: @skill
      expect(response).to redirect_to skills_path
    end

  end
end
