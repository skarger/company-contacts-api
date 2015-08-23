require 'spec_helper'

describe "serialized contact point", type: :feature do
  it "should match a JSON API compliant pattern" do
    contact_point_pattern = {
      type: "ContactPoint",
      id: "1",
      links: {
        self: /#{organization_url}\/contact_points\/\d/
      },
      attributes: {
        areaServed: ["US"],
        phoneNumber: "1-866-123-4567"
      }
    }
    visit "#{organization_url}/public_contact_points"
    contact_point_US = ContactPoint.new(1, ["US"], "1-866-123-4567")
    expect(serialize_contact_point(contact_point_US)).
      to match_json_expression(contact_point_pattern)
  end
end
