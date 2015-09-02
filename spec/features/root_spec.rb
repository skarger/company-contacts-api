require_relative "../spec_helper.rb"

Capybara.app = OrganizationalContactsApi

describe "root path", :type => :feature do
  it "should redirect to the named home page" do
    visit '/'
    expect(current_path).to eq("/home")
  end
end
