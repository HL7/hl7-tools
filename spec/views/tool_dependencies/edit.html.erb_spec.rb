require 'rails_helper'

RSpec.describe 'tool_dependencies/edit', type: :view do
  before(:each) do
    @tool = assign(:tool, FactoryGirl.create(:tool))
    @tool2 = assign(:tool2, FactoryGirl.create(:tool, name: 'Other Tool'))
    @tool_dependency = assign(:tool_dependency, FactoryGirl.create(:tool_dependency, tool: @tool,
                                                                   dependency: @tool2))
  end

  it 'renders the edit tool_dependency form' do
    render

    assert_select 'form[action=?][method=?]', tool_tool_dependency_path(@tool, @tool_dependency), 'post' do
    # assert_select 'form[method=?]', 'post' do
    end
  end
end
