require 'rails_helper'

RSpec.describe ToolPeopleController, type: :controller do

  let(:valid_session) { {} }

  context 'in admin mode' do
    let(:tool) { FactoryGirl.create(:tool) }

    around(:example) do |example|
      ENV['HL7_TOOL_EDITING'] = 'TRUE'
      example.run
      ENV.delete('HL7_TOOL_EDITING')
    end

    describe 'GET #new' do
      it 'assigns a new tool_person as @tool_person' do
        get :new, {tool_id: tool.id}, valid_session
        expect(assigns(:tool_person)).to be_a_new(ToolPerson)
      end
    end

    describe 'Get #edit' do
      it 'should be tested'
    end

    describe 'POST #create' do
      context 'with valid params' do
        let(:valid_attributes) { FactoryGirl.attributes_for(:tool_person,
                                                            person_org_id: FactoryGirl.create(:person_org).id) }

        it 'creates a new ToolPerson' do
          expect {
            post :create, {tool_id: tool.id, tool_person: valid_attributes}, valid_session
          }.to change(ToolPerson, :count).by(1)
        end

        it 'assigns a newly created tool_person as @tool_person' do
          post :create, {tool_id: tool.id, tool_person: valid_attributes}, valid_session
          expect(assigns(:tool_person)).to be_a(ToolPerson)
          expect(assigns(:tool_person)).to be_persisted
        end

        it 'redirects to the created tool_person' do
          post :create, {tool_id: tool.id, tool_person: valid_attributes}, valid_session
          expect(response).to redirect_to(tool)
        end
      end

      context 'with invalid params' do
        let(:invalid_attributes) { FactoryGirl.attributes_for(:tool_person, person_org_id: nil) }

        it 'assigns a newly created but unsaved tool_person as @tool_person' do
          post :create, {tool_id: tool.id, tool_person: invalid_attributes}, valid_session
          expect(assigns(:tool_person)).to be_a_new(ToolPerson)
        end

        it 're-renders the new template' do
          post :create, {tool_id: tool.id, tool_person: invalid_attributes}, valid_session
          expect(response).to render_template(:new)
        end
      end
    end

    describe 'PUT #update' do
      it 'should be tested'
    end
  end
end
