Given(/^I have a sample tool stored$/) do
  FactoryGirl.create(:cucumber_sample_tool)
end

Given(/^I am on the 'Tool Details' page$/) do
  x = Tool.first
  visit tool_path(x.id)
end

Given(/^I should see (.+) label$/) do |label_name|
  expect(page).to have_content(label_name)
end

Given(/^I should see text '(.+)'$/) do |page_text|
  expect(page).to have_content(page_text)
end

Given(/^I should see the link '(.+)' with an address of '(.+)'$/) do |link_name, link_addr|
  found = "#{link_name} not found"
  all('a').each do |a|
    if a.text == link_name
      expect(a[:href]).to eq(link_addr)
      found = 'found'
    end
  end
  expect(found).to eq('found')
end