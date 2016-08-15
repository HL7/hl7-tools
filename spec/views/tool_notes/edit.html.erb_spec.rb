require 'rails_helper'

RSpec.describe 'tool_notes/edit', type: :view do
  before(:each) do
    @tool = assign(:tool, FactoryGirl.create(:tool))
    @tool_note = assign(:tool_note, FactoryGirl.create(:tool_note, tool: @tool))
  end

  it 'renders the edit tool_note form' do
    render

    assert_select 'form[action=?][method=?]', tool_tool_note_path(@tool, @tool_note), 'post' do
    end
  end
end
