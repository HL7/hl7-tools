require 'rails_helper'

RSpec.describe "tools/edit", type: :view do
  before(:each) do
    @tool = assign(:tool, Tool.create!(
      :name => "MyString",
      :description => "MyString",
      :purpose => "MyString",
      :url => "MyString",
      :version => "MyString"
    ))
  end

  it "renders the edit tool form" do
    render

    assert_select "form[action=?][method=?]", tool_path(@tool), "post" do

      assert_select "input#tool_name[name=?]", "tool[name]"

      assert_select "input#tool_description[name=?]", "tool[description]"

      assert_select "input#tool_purpose[name=?]", "tool[purpose]"

      assert_select "input#tool_url[name=?]", "tool[url]"

      assert_select "input#tool_version[name=?]", "tool[version]"
    end
  end
end
