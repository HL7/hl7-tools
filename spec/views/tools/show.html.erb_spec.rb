require 'rails_helper'

RSpec.describe 'tools/show', type: :view do
  before(:each) do
    @tool = assign(:tool, Tool.create!(
      :name => 'Name',
      :description => 'Description',
      :purpose => 'Purpose',
      :url => 'Url',
      :version => 'Version'
    ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Description/)
    expect(rendered).to match(/Purpose/)
    expect(rendered).to match(/Url/)
    expect(rendered).to match(/Version/)
  end
end
