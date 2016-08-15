require 'rails_helper'

RSpec.describe 'ToolPeople', type: :request do
  let(:tool) { FactoryGirl.create(:tool) }

  context 'in admin mode' do
    around(:example) do |example|
      ENV['HL7_TOOL_EDITING'] = 'TRUE'
      example.run
      ENV.delete('HL7_TOOL_EDITING')
    end

    describe 'GET /tool_people/new' do
      it 'displays the new form' do
        get new_tool_tool_person_path(tool.id)
        expect(response).to have_http_status(200)
      end
    end

    describe 'POST /tool_people' do
      it 'saves new object' do
        person = FactoryGirl.create(:person_org)
        object_attrs = FactoryGirl.attributes_for(:tool_person, person_org_id: person.id)
        # puts object_attrs
        post tool_tool_people_path(tool.id), { tool_person: object_attrs }
        errors = assigns(:tool_person).errors
        puts errors.messages if errors && errors.count > 0
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(tool_path(tool))
        expect(flash[:notice]).to be_present
        expect(flash[:notice]).to eq 'Tool person was successfully created.'
      end
    end
  end

  context 'in regular mode' do
    describe 'GET /tool_people/new' do
      it 'redirects to root' do
        get new_tool_tool_person_path(tool.id)
        expect(response).to have_http_status :redirect
        expect(response).to redirect_to(root_path)
      end
    end

    describe 'POST /tool_people' do
      it 'redirects to root' do
        post tool_tool_people_path(tool.id)
        expect(response).to have_http_status :redirect
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
