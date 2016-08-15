require 'rails_helper'

RSpec.describe 'ToolDependencies', type: :request do
  let(:tool) { FactoryGirl.create(:tool) }

  context 'in admin mode' do
    around(:example) do |example|
      ENV['HL7_TOOL_EDITING'] = 'TRUE'
      example.run
      ENV.delete('HL7_TOOL_EDITING')
    end

    describe 'GET /tool_dependencies/new' do
      it 'displays the new form' do
        get new_tool_tool_dependency_path(tool.id)
        expect(response).to have_http_status(200)
      end
    end

    describe 'POST /tool_dependencies' do
      it 'saves new object' do
        other_tool = FactoryGirl.create(:tool)
        object_attrs = FactoryGirl.attributes_for(:tool_dependency, dependency_id: other_tool.id)
        # puts object_attrs
        post tool_tool_dependencies_path(tool.id), { tool_dependency: object_attrs }
        errors = assigns(:tool_dependency).errors
        puts errors.messages if errors && errors.count > 0
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(tool_path(tool))
        expect(flash[:notice]).to be_present
        expect(flash[:notice]).to eq 'Tool dependency was successfully created.'
      end
    end
  end

  context 'in regular mode' do
    describe 'GET /tool_dependencies/new' do
      it 'redirects to root' do
        get new_tool_tool_dependency_path(tool.id)
        expect(response).to have_http_status :redirect
        expect(response).to redirect_to(root_path)
      end
    end

    describe 'POST /tool_dependencies' do
      it 'redirects to root' do
        post tool_tool_dependencies_path(tool.id)
        expect(response).to have_http_status :redirect
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
