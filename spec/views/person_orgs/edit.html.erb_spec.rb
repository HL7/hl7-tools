require 'rails_helper'

RSpec.describe 'person_orgs/edit', type: :view do
  before(:each) do
    @person_org = assign(:person_org, FactoryGirl.create(:person_org))
  end

  it 'renders the edit person_org form' do
    render

    assert_select 'form[action=?][method=?]', person_org_path(@person_org), 'post' do
    end
  end
end
