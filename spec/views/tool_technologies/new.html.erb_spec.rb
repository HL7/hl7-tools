require 'rails_helper'

RSpec.describe 'tool_technologies/new', type: :view do
  before(:each) do
    @tool = assign(:tool, FactoryGirl.create(:tool))
    assign(:tool_technology, ToolTechnology.new())
  end

  it 'renders new tool_technology form' do
    render

    assert_select 'form[action=?][method=?]', tool_tool_technologies_path(@tool), 'post' do
    end
  end
end
