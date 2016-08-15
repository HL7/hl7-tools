require 'rails_helper'

RSpec.describe 'tool_users/edit', type: :view do
  before(:each) do
    @tool = assign(:tool, FactoryGirl.create(:tool))
    @tool_user = assign(:tool_user, FactoryGirl.create(:tool_user, tool: @tool))
  end

  it 'renders the edit tool_user form' do
    render

    assert_select 'form[action=?][method=?]', tool_tool_user_path(@tool, @tool_user), 'post' do
    end
  end
end
