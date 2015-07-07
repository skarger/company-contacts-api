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

  it "should have Organization and Place elements with links" do
    top_level_data_pattern = {
      data: [
        {
          type: "Organization",
          id: "1",
          links: {
            self: "#{base_url}/organizations/1"
          }
        }, {
          type: "Place",
          id: "1",
          links: {
            self: "#{base_url}/places/1"
          }
        }
      ]
    }.ignore_extra_keys!
    visit '/home'
    expect(JSON.parse(page.body)).to match_json_expression(top_level_data_pattern)
  end

end
