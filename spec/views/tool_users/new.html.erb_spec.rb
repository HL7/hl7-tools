require 'rails_helper'

RSpec.describe 'tool_users/new', type: :view do
  before(:each) do
    @tool = assign(:tool, FactoryGirl.create(:tool))
    assign(:tool_user, FactoryGirl.build(:tool_user, ))
  end

  it 'renders new tool_user form' do
    render

    assert_select 'form[action=?][method=?]', tool_tool_users_path(@tool), 'post' do
    end
  end
end
