require 'rails_helper'

RSpec.describe "Tools", type: :request do
  describe "GET /tools" do
    it "works! (now write some real specs)" do
      get tools_path
      expect(response).to have_http_status(200)
    end
  end
end
