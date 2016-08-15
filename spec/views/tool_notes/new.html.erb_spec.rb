require 'rails_helper'

RSpec.describe 'tool_notes/new', type: :view do
  before(:each) do
    @tool = assign(:tool, FactoryGirl.create(:tool))
    assign(:tool_note, FactoryGirl.build(:tool_note, tool: @tool))
  end

  it 'renders new tool_note form' do
    render

    assert_select 'form[action=?][method=?]', tool_tool_notes_path(@tool), 'post' do
    end
  end
end
