require 'rails_helper'

RSpec.describe "tools/new", type: :view do
  before(:each) do
    assign(:tool, Tool.new(
      :name => "MyString",
      :description => "MyString",
      :purpose => "MyString",
      :url => "MyString",
      :version => "MyString"
    ))
  end

  it "renders new tool form" do
    render

    assert_select "form[action=?][method=?]", tools_path, "post" do

      assert_select "input#tool_name[name=?]", "tool[name]"

      assert_select "input#tool_description[name=?]", "tool[description]"

      assert_select "input#tool_purpose[name=?]", "tool[purpose]"

      assert_select "input#tool_url[name=?]", "tool[url]"

      assert_select "input#tool_version[name=?]", "tool[version]"
    end
  end
end
