require_relative '../spec_helper.rb'

describe "administrative_areas collection endpoint", type: :feature do
  it "should successfully respond to the canonical administrative_areas link" do
    get "#{organization_url}/administrative_areas"
    expect(last_response.status).to eq(200)
  end

  it "should have a link to itself at the top level" do
    top_level_links_pattern = {
      links: {
        self: "#{organization_url}/administrative_areas"
      }
    }.ignore_extra_keys!
    visit "#{organization_url}/administrative_areas"
    expect(page.body).to match_json_expression(top_level_links_pattern)
  end
end
