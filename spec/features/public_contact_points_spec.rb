require_relative '../spec_helper.rb'

describe "public contact points endpoint", type: :feature do
  it "should respond with a 200 to the organization related link" do
    get "#{organization_url}/public_contact_points"
    expect(last_response.status).to eq(200)
  end

  it "should have a links object" do
    top_level_links_pattern = {
      links: {
        self: "#{organization_url}/public_contact_points"
      }
    }.ignore_extra_keys!
    visit "#{organization_url}/public_contact_points"
    expect(page.body).to match_json_expression(top_level_links_pattern)
  end

  it "should have a data object with a collection of ContactPoint values" do
    data_collection_pattern = {
      data: [{
        type: "ContactPoint",
        id: "1"
      }.ignore_extra_keys!]
    }.ignore_extra_keys!
    visit "#{organization_url}/public_contact_points"
    expect(page.body).to match_json_expression(data_collection_pattern)
  end
end
