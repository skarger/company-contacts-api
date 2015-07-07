require_relative "../spec_helper.rb"

Capybara.app = CompanyContactsApi

describe "the home page", :type => :feature do
  base_url = "http://localhost:3000"
  home_page_description = CompanyContactsApi.new({}).home_page_description

  it "should have a links element with a link to itself" do
    links_pattern = {
      links: {
          self: "#{base_url}/home"
      }
    }.ignore_extra_keys!
    visit '/home'
    expect(JSON.parse(page.body)).to match_json_expression(links_pattern)
  end

  it "should have type and id elements" do
    top_level_data_pattern = {
      data: [
        {
          id: 1,
          type: "WebPage"
        }.ignore_extra_keys!
      ]
    }.ignore_extra_keys!
    visit '/home'
    expect(JSON.parse(page.body)).to match_json_expression(top_level_data_pattern)
  end

  it "should have a description of the website in the attributes" do
    top_level_data_pattern = {
      data: [
        {
          attributes: {
            mainContentOfPage: "#{home_page_description}"
          }
        }.ignore_extra_keys!
      ]
    }.ignore_extra_keys!
    visit '/home'
    expect(JSON.parse(page.body)).to match_json_expression(top_level_data_pattern)
  end

  it "should have a relationship link to the Organization" do
    relationships_pattern = {
      data: [
        {
          relationships: {
            organization: {
              links: {
                self: "#{base_url}/relationships/organization",
                related: "#{base_url}/organization"
              }
            }
          }
        }.ignore_extra_keys!
      ]
    }.ignore_extra_keys!
    visit '/home'
    expect(JSON.parse(page.body)).to match_json_expression(relationships_pattern)
  end
end
