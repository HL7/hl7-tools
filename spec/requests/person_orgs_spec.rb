require 'rails_helper'

RSpec.describe 'PersonOrgs', type: :request do
  context 'in admin mode' do
    around(:example) do |example|
      ENV['HL7_TOOL_EDITING'] = 'TRUE'
      example.run
      ENV.delete('HL7_TOOL_EDITING')
    end

    describe 'GET /person_orgs' do
      before(:each) do
        FactoryGirl.create_list(:person_org, 10)
      end

      it 'should retrieve index with admin' do
        # allow(@controller).to receive(:admin_install?) { true }
        get person_orgs_path
        expect(response).to have_http_status :success
        expect(response).to render_template(:index)
      end
    end

    describe 'GET /person_orgs/:id' do
      let(:person) { FactoryGirl.create(:person_org) }

      it 'should retrieve individual person/organization' do
        get person_org_path(person.id)
        expect(response.status).to be(200)
        expect(response).to render_template(:show)
      end
    end
  end

  context 'in regular mode' do
    describe 'GET /person_orgs' do
      before(:each) do
        FactoryGirl.create_list(:person_org, 10)
      end

      it 'should redirect without admin' do
        get person_orgs_path
        expect(response).to have_http_status :redirect
        expect(response).to redirect_to(root_path)
      end
    end

    describe 'GET /person_orgs/:id' do
      let(:person) { FactoryGirl.create(:person_org) }

      it 'should retrieve individual person/organization' do
        get person_org_path(person.id)
        expect(response).to have_http_status :redirect
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
