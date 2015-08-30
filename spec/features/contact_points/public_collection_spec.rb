require 'spec_helper'

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
    contact_point_US = ContactPoint.new(
      attributes: {id: 1, area_served: ["US"], phone_number: "1-866-123-4567"},
      organization: primary_organization
    )
    contact_point_CA = ContactPoint.new(
      attributes: {id: 2, area_served: ["CA"], phone_number: "1-866-987-6543"},
      organization: primary_organization
    )
    contact_point_GB = ContactPoint.new(
      attributes: {id: 3, area_served: ["GB"], phone_number: "44 1234 567"},
      organization: primary_organization
    )
    data_collection_pattern = {
      data: [
        ContactPointPresenter.new(contact_point_US).resource_object,
        ContactPointPresenter.new(contact_point_CA).resource_object,
        ContactPointPresenter.new(contact_point_GB).resource_object
      ]
    }.ignore_extra_keys!
    visit "#{organization_url}/public_contact_points"
    expect(page.body).to match_json_expression(data_collection_pattern)
  end
end
