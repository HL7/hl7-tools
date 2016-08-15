require 'rails_helper'

RSpec.describe 'tools/index', type: :view do
  before(:each) do
    assign(:tools, FactoryGirl.create_list(:tool, 2))
  end

  it 'renders a list of tools' do
    render
    assert_select 'tr>td', text:'MyString'.to_s, count: 2
  end
end
