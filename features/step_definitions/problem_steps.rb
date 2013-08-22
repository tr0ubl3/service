Given(/^I am not yet on web application$/) do
  
end

When(/^I open application$/) do
	visit ('/')
end

Then(/^I should see "(.*?)"$/) do |arg1|
	find('h1').should have_content "International G&T web platform"
	find('title').should have_content "Login"
end