require 'spec_helper'

describe "layouts/application.html.erb" do
	before :each do
		@user = create(:user)
		view.stub(:current_user).and_return(@user)
	end

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

	it "has current_user link in the navbar" do
		render
		expect(rendered).to have_link("#{@user.full_name}", :href => '#')
	end

	it "has div container for bullet notifications with number of pending users" do
		create(:user2)
		render
		expect(rendered).to have_css("div.admin_notifications", text: "#{pending_users}")
	end

	it "has link manage_users_path" do
		create(:user2)
		render
		expect(rendered).to have_link("#{pending_users}", :href => manage_users_path)
	end
end