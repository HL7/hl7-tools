require 'rails_helper'

RSpec.describe ToolsController, type: :controller do
  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'assigns all tools as @tools' do
      tool = FactoryGirl.create(:tool)
      get :index, {}, valid_session
      expect(assigns(:tools)).to eq([tool])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested tool as @tool' do
      tool = FactoryGirl.create(:tool)
      get :show, {:id => tool.to_param}, valid_session
      expect(assigns(:tool)).to eq(tool)
    end
  end

  describe 'in admin mode' do
    around(:example) do |example|
      ENV['HL7_TOOL_EDITING'] = 'TRUE'
      example.run
      ENV.delete('HL7_TOOL_EDITING')
    end

    describe 'GET #new' do
      it 'assigns a new tool as @tool' do
        get :new, {}, valid_session
        expect(assigns(:tool)).to be_a(Tool)
      end
    end

    describe 'GET #edit' do
      it 'assigns the requested tool as @tool' do
        tool = FactoryGirl.create(:tool)
        get :edit, {:id => tool.to_param}, valid_session
        expect(assigns(:tool)).to eq(tool)
      end
    end

    describe 'POST #create' do
      context 'with valid params' do
        let(:valid_attributes) {FactoryGirl.attributes_for(:tool)}

        it 'creates a new Tool' do
          expect {
            post :create, {:tool => valid_attributes}, valid_session
          }.to change(Tool, :count).by(1)
        end

        it 'assigns a newly created tool as @tool' do
          post :create, {:tool => valid_attributes}, valid_session
          expect(assigns(:tool)).to be_a(Tool)
          expect(assigns(:tool)).to be_persisted
        end

        it 'redirects to the created tool' do
          post :create, {:tool => valid_attributes}, valid_session
          expect(response).to redirect_to(Tool.last)
        end
      end

      context 'with invalid params' do
        let(:invalid_attributes) {FactoryGirl.attributes_for(:tool, license: 'fred')}

        it 'assigns a newly created but unsaved tool as @tool' do
          post :create, {:tool => invalid_attributes}, valid_session
          expect(assigns(:tool)).to be_a_new(Tool)
        end

        it 're-renders the new template' do
          post :create, {:tool => invalid_attributes}, valid_session
          expect(response).to render_template(:new)
        end
      end
    end

    describe 'PUT #update' do
      context 'with valid params' do
        let(:new_attributes) { { license: 'OSS'} }

        it 'updates the requested tool' do
          tool = FactoryGirl.create(:tool)
          put :update, {:id => tool.to_param, :tool => new_attributes}, valid_session
          tool.reload
          expect(tool.license).to eq 'OSS'
        end

        it 'assigns the requested tool as @tool' do
          tool = FactoryGirl.create(:tool)
          put :update, {:id => tool.to_param, :tool => new_attributes}, valid_session
          expect(assigns(:tool)).to eq(tool)
        end

        it 'redirects to the tool' do
          tool = FactoryGirl.create(:tool)
          put :update, {:id => tool.to_param, :tool => new_attributes}, valid_session
          expect(response).to redirect_to(tool)
        end
      end

      context 'with invalid params' do
        let(:invalid_attributes) { { license: 'fred'} }

        it 'assigns the tool as @tool' do
          tool = FactoryGirl.create(:tool)
          put :update, {:id => tool.to_param, :tool => invalid_attributes}, valid_session
          expect(assigns(:tool)).to eq(tool)
        end

        it 're-renders the edit template' do
          tool = FactoryGirl.create(:tool)
          put :update, {:id => tool.to_param, :tool => invalid_attributes}, valid_session
          expect(response).to render_template(:edit)
        end
      end
    end
  end
end
