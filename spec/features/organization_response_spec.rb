require_relative '../spec_helper.rb'

describe "primary organization endpoint", type: :feature do
  let(:primary_organization_id) { 1 }

  let(:included_pattern) {
    {
      included: [{
        type: "ContactPoint",
        id: "1"
      }]
    }.ignore_extra_keys!
  }

  it "should return an included object with the canonical link" do
    visit "/organizations/#{primary_organization_id}"
    expect(page.body).to match_json_expression(included_pattern)
  end

  it "should return an included object with the home related link" do
    visit "/home/organization"
    expect(page.body).to match_json_expression(included_pattern)
  end
end

