require 'rails_helper'

RSpec.describe 'tool_technologies/edit', type: :view do
  before(:each) do
    @tool = assign(:tool, FactoryGirl.create(:tool))
    @tool_technology = assign(:tool_technology, FactoryGirl.create(:tool_technology, tool: @tool))
  end

  it 'renders the edit tool_technology form' do
    render

    assert_select 'form[action=?][method=?]', tool_tool_technology_path(@tool, @tool_technology), 'post' do
    end
  end
end
