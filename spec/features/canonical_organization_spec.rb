require_relative '../spec_helper.rb'

describe "primary organization endpoint", type: :feature do
  let(:primary_organization_id) { 1 }

  it "should successfully respond to the canonical organization link" do
    get "/organizations/#{primary_organization_id}"
    expect(last_response.status).to eq(200)
  end

  it "should have a link to itself at the top level" do
    top_level_links_pattern = {
      links: {
        self: /#{base_url}\/organizations\/\d/
      }
    }.ignore_extra_keys!
    visit "/organizations/#{primary_organization_id}"
    expect(page.body).to match_json_expression(top_level_links_pattern)
  end
end
