require 'spec_helper'

describe "layouts/application.html.erb" do
	it "doesn't have a flash block without a flash message" do
		render
		expect(rendered).not_to have_css('.alert')
	end
	it "has a flash block for feedback" do
		flash[:notice] = "Testing the flash display block"
		render
		expect(rendered).to have_content('Testing the flash display block')
	end
	it 'has a flash message with css bootstrap alert-error' do
		flash[:alert] = "This is an alert error"
		render
		expect(rendered).to have_css('.alert-error')
	end
	it 'has a flash message with css bootstrap alert-success' do
		flash[:notice] = "This is a notice message"
		render
		expect(rendered).to have_css('.alert-success')
	end
end