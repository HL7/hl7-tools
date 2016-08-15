require 'rails_helper'

RSpec.describe ToolNotesController, type: :controller do

  let(:valid_session) { {} }

  context 'in admin mode' do
    let(:tool) { FactoryGirl.create(:tool) }

    around(:example) do |example|
      ENV['HL7_TOOL_EDITING'] = 'TRUE'
      example.run
      ENV.delete('HL7_TOOL_EDITING')
    end

    describe 'GET #new' do
      it 'assigns a new tool_note as @tool_note' do
        get :new, {tool_id: tool.id}, valid_session
        expect(assigns(:tool_note)).to be_a_new(ToolNote)
      end
    end

    describe 'Get #edit' do
      it 'should be tested'
    end

    describe 'POST #create' do
      context 'with valid params' do
        let(:valid_attributes) { FactoryGirl.attributes_for(:tool_note) }

        it 'creates a new ToolNote' do
          expect {
            post :create, {tool_id: tool.id, tool_note: valid_attributes}, valid_session
          }.to change(ToolNote, :count).by(1)
        end

        it 'assigns a newly created tool_note as @tool_note' do
          post :create, {tool_id: tool.id, tool_note: valid_attributes}, valid_session
          expect(assigns(:tool_note)).to be_a(ToolNote)
          expect(assigns(:tool_note)).to be_persisted
        end

        it 'redirects to the created tool_note' do
          post :create, {tool_id: tool.id, tool_note: valid_attributes}, valid_session
          expect(response).to redirect_to(tool)
        end
      end

      context 'with invalid params' do
        let(:invalid_attributes) { FactoryGirl.attributes_for(:tool_note, note: nil) }

        it 'assigns a newly created but unsaved tool_note as @tool_note' do
          post :create, {tool_id: tool.id, tool_note: invalid_attributes}, valid_session
          expect(assigns(:tool_note)).to be_a_new(ToolNote)
        end

        it 're-renders the new template' do
          post :create, {tool_id: tool.id, tool_note: invalid_attributes}, valid_session
          expect(response).to render_template(:new)
        end
      end
    end

    describe 'PUT #update' do
      it 'should be tested'
    end
  end
end
