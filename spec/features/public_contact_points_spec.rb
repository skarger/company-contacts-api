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
    contact_point_US = ContactPoint.new(1, ["US"], "1-866-123-4567")
    contact_point_CA = ContactPoint.new(2, ["CA"], "1-866-987-6543")
    contact_point_GB = ContactPoint.new(3, ["GB"], "44 1234 567")
    data_collection_pattern = {
      data: [
        serialize_contact_point(contact_point_US),
        serialize_contact_point(contact_point_CA),
        serialize_contact_point(contact_point_GB)
      ]
    }.ignore_extra_keys!
    visit "#{organization_url}/public_contact_points"
    expect(page.body).to match_json_expression(data_collection_pattern)
  end
end
