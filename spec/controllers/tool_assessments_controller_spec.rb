require 'rails_helper'

RSpec.describe ToolAssessmentsController, type: :controller do

  let(:valid_session) { {} }

  context 'in admin mode' do
    let(:tool) { FactoryGirl.create(:tool) }

    around(:example) do |example|
      ENV['HL7_TOOL_EDITING'] = 'TRUE'
      example.run
      ENV.delete('HL7_TOOL_EDITING')
    end

    describe 'GET #new' do
      it 'assigns a new tool_assessment as @tool_assessment' do
        get :new, {tool_id: tool.id}, valid_session
        expect(assigns(:tool_assessment)).to be_a_new(ToolAssessment)
      end
    end

    describe 'POST #create' do
      context 'with valid params' do
        let(:valid_attributes) { FactoryGirl.attributes_for(:tool_assessment) }

        it 'creates a new ToolAssessment' do
          expect {
            post :create, {tool_id: tool.id, tool_assessment: valid_attributes}, valid_session
          }.to change(ToolAssessment, :count).by(1)
        end

        it 'assigns a newly created tool_assessment as @tool_assessment' do
          post :create, {tool_id: tool.id, tool_assessment: valid_attributes}, valid_session
          expect(assigns(:tool_assessment)).to be_a(ToolAssessment)
          expect(assigns(:tool_assessment)).to be_persisted
        end

        it 'redirects to the created tool_assessment' do
          post :create, {tool_id: tool.id, tool_assessment: valid_attributes}, valid_session
          expect(response).to redirect_to(tool)
        end
      end

      context 'with invalid params' do
        let(:invalid_attributes) { FactoryGirl.attributes_for(:tool_assessment, assessment_date: nil) }

        it 'assigns a newly created but unsaved tool_assessment as @tool_assessment' do
          post :create, {tool_id: tool.id, tool_assessment: invalid_attributes}, valid_session
          expect(assigns(:tool_assessment)).to be_a_new(ToolAssessment)
        end

        it 're-renders the new template' do
          post :create, {tool_id: tool.id, tool_assessment: invalid_attributes}, valid_session
          expect(response).to render_template(:new)
        end
      end
    end
  end
end
