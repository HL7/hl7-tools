require 'rails_helper'

RSpec.describe 'Tools', type: :request do
  describe 'GET /tools' do
    before(:each) do
      FactoryGirl.create_list(:tool, 10)
    end

    it 'should retrieve tool index' do
      get tools_path
      expect(response).to have_http_status :success
      expect(response).to render_template(:index)
    end

    it 'should retrieve with query' do
      search_val = 'Banting'
      FactoryGirl.create_list(:tool, 5, name: [search_val])
      get '/tools', {query: {name: {value: search_val}}}
      expect(response).to have_http_status :success
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /tools/:id' do
    let(:tool) { FactoryGirl.create(:tool) }

    it 'should retrieve individual tool' do
      get tool_path(tool.id)
      expect(response.status).to be(200)
      expect(response).to render_template(:show)
    end
  end
end
