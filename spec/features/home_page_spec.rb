require_relative "../spec_helper.rb"

Capybara.app = CompanyContactsApi

describe "the home page", :type => :feature do
  it "should say hello" do
    visit '/'
    expect(page).to have_content 'hello'
  end
end
