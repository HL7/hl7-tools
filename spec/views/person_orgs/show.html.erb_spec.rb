require 'rails_helper'

RSpec.describe 'person_orgs/show', type: :view do
  before(:each) do
    @person_org = assign(:person_org, FactoryGirl.create(:person_org))
  end

  it 'renders attributes in <p>' do
    render

    assert_select 'p' do
      assert_select 'strong', 'Name:'
    end
  end
end
