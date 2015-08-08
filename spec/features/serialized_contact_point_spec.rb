require_relative '../spec_helper.rb'

describe "serialized contact point", type: :feature do
  it "should match a JSON API compliant pattern" do
    contact_point_pattern = {
      type: "ContactPoint",
      id: "1",
      links: {
        self: /#{organization_url}\/contact_points\/\d/
      },
      attributes: {}
    }
    visit "#{organization_url}/public_contact_points"
    cp = ContactPoint.new(1)
    expect(serialize_contact_point(cp)).to match_json_expression(contact_point_pattern)
  end
end
