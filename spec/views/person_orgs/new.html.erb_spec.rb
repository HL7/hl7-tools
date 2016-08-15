require 'rails_helper'

RSpec.describe "person_orgs/new", type: :view do
  before(:each) do
    assign(:person_org, PersonOrg.new())
  end

  it "renders new person_org form" do
    render

    assert_select "form[action=?][method=?]", person_orgs_path, "post" do
    end
  end
end
