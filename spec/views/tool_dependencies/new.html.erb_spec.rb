require 'rails_helper'

RSpec.describe 'tool_dependencies/new', type: :view do
  before(:each) do
    @tool = assign(:tool, FactoryGirl.create(:tool))
    assign(:tool_dependency, FactoryGirl.build(:tool_dependency, tool: @tool))
  end

  it 'renders new tool_dependency form' do
    render

    assert_select 'form[action=?][method=?]', tool_tool_dependencies_path(@tool), 'post' do
    end
  end
end
