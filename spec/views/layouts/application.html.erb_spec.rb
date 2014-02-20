require 'spec_helper'

describe "layouts/application.html.erb" do
	before :each do
		@user = create(:user)
		view.stub(:current_user).and_return(@user)
		render
	end

	

	# it "doesn't have a flash block without a flash message" do
	# 	expect(rendered).not_to have_css('.alert')
	# end

	# it "has a flash block for feedback" do
	# 	flash[:notice] = "Testing the flash display block"
	# 	render
	# 	expect(rendered).to have_content('Testing the flash display block')
	# end

	# it 'has a flash message with css bootstrap alert-error' do
	# 	flash[:alert] = "This is an alert error"
	# 	render
	# 	expect(rendered).to have_css('.alert-error')
	# end

	# it 'has a flash message with css bootstrap alert-success' do
	# 	flash[:notice] = "This is a notice message"
	# 	render
	# 	expect(rendered).to have_css('.alert-success')
	# end

	# it "has current_user link in the navbar" do
	# 	expect(rendered).to have_link("#{@user.full_name}", :href => '#')
	# end

	# it "has Account link in the navabar" do
	# 	expect(rendered).to have_link("Account settings", href: edit_user_path(@user))		
	# end
end