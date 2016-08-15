require 'rails_helper'

RSpec.describe 'ToolNotes', type: :request do
  let(:tool) { FactoryGirl.create(:tool) }

  context 'in admin mode' do
    around(:example) do |example|
      ENV['HL7_TOOL_EDITING'] = 'TRUE'
      example.run
      ENV.delete('HL7_TOOL_EDITING')
    end

    describe 'GET /tool_notes/new' do
      it 'displays the new form' do
        get new_tool_tool_note_path(tool.id)
        expect(response).to have_http_status(200)
      end
    end

    describe 'POST /tool_notes' do
      it 'saves new object' do
        object_attrs = FactoryGirl.attributes_for(:tool_note)
        # puts object_attrs
        post tool_tool_notes_path(tool.id), { tool_note: object_attrs }
        errors = assigns(:tool_note).errors
        puts errors.messages if errors && errors.count > 0
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(tool_path(tool))
        expect(flash[:notice]).to be_present
        expect(flash[:notice]).to eq 'Tool note was successfully created.'
      end
    end
  end

  context 'in regular mode' do
    describe 'GET /tool_notes/new' do
      it 'redirects to root' do
        get new_tool_tool_note_path(tool.id)
        expect(response).to have_http_status :redirect
        expect(response).to redirect_to(root_path)
      end
    end

    describe 'POST /tool_notes' do
      it 'redirects to root' do
        post tool_tool_notes_path(tool.id)
        expect(response).to have_http_status :redirect
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
