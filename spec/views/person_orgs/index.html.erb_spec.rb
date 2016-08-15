require 'rails_helper'

RSpec.describe 'person_orgs/index', type: :view do
  before(:each) do
    assign(:person_orgs, FactoryGirl.create_list(:person_org, 2))
  end

  it 'renders a list of person_orgs' do
    render

    assert_select 'table' do
      assert_select 'tr', 3
    end
  end
end
