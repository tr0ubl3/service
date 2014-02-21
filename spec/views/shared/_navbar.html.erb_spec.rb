require 'spec_helper'

describe 'shared/_navbar.html.erb' do
	before do
		@user = create(:user)
		view.stub(:current_user).and_return(@user)
		render
	end

	it "has div with 'navbar navbar-inverse navbar-fixed-top'" do
		expect(rendered).to have_selector("div.navbar.navbar-inverse.navbar-fixed-top")
	end

	it "has div.navbar-inner" do
		expect(rendered).to have_selector("div.navbar-inner")
	end

	it "has container-fluid" do
		expect(rendered).to have_selector("div.container-fluid")
	end

	it "it has Service link to root path" do
		expect(rendered).to have_link("Service", href: root_path)
	end

	it "has div.nav-collapse collapse" do
		expect(rendered).to have_selector("div.nav-collapse.collapse")
	end

	it "has div dropdown pull-right navbar-text with text 'Logged in as _user'" do
		expect(rendered).to have_selector("div.dropdown.pull-right.navbar-text", text: "Logged in as #{@user.full_name}")
	end

	it "has ul.dropdown-menu" do
		expect(rendered).to have_selector('ul.dropdown-menu')
	end

	it "has ul>li>a with text 'Account settings'" do
		expect(rendered).to have_link('Account settings', href: edit_user_path(@user))
	end

	it "has ul>li>a'Account settings'>i" do
		expect(rendered).to have_selector('i.icon-wrench')
	end

	it "has ul>li>a with text 'Logout'" do
		expect(rendered).to have_link('Logout', href: logout_path)
	end

	it "has ul>li>a>i.icon-off" do
		expect(rendered).to have_selector('i.icon-off')
	end

	it "doesn't see  control panel link" do
		expect(rendered).not_to have_link("Control panel", href: control_panel_general_index_path)
	end

	it "doesn't have admin_notifications" do
		expect(rendered).not_to have_selector("div.admin_notifications")
	end

	context "admin user" do
		before do
			@user.destroy
			@admin = create(:admin)
			view.stub(:current_user).and_return(@admin)
			render
		end

		it "has admin notification div" do
			expect(rendered).to have_selector("div.admin_notifications")
		end

		it "has control panel link in menu" do
			expect(rendered).to have_link("Control panel", href: control_panel_general_index_path)
		end
	end
end