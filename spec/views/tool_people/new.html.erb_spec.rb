require 'rails_helper'

RSpec.describe 'tool_people/new', type: :view do
  before(:each) do
    @tool = assign(:tool, FactoryGirl.create(:tool))
    assign(:tool_person, ToolPerson.new())
  end

  it 'renders new tool_person form' do
    render

    assert_select 'form[action=?][method=?]', tool_tool_people_path(@tool), 'post' do
    end
  end
end
