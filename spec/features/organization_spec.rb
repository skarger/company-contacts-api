require_relative '../spec_helper.rb'

describe "primary organization endpoint", type: :feature do
  it "should have a link to itself" do
    top_level_links_pattern = {
      links: {
        self: /#{base_url}\/organizations\/\d/
      }
    }
    primary_organization_id = 1
    visit "/organizations/#{primary_organization_id}"
    expect(page.body).to match_json_expression(top_level_links_pattern)
  end
end
