require 'rails_helper'

RSpec.describe 'tool_people/edit', type: :view do
  before(:each) do
    @tool = FactoryGirl.create(:tool)
    @tool_person = assign(:tool_person, FactoryGirl.create(:tool_person, tool: @tool,
                                                           person_org: FactoryGirl.create(:person_org)))
  end

  it 'renders the edit tool_person form' do
    render

    assert_select 'form[action=?][method=?]', tool_tool_person_path(@tool,@tool_person), 'post' do
    end
  end
end
