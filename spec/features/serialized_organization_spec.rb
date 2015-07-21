require_relative '../spec_helper.rb'

describe "primary organization endpoint", type: :feature do
  let(:primary_organization_id) { 1 }

  let(:organization_data_pattern) {
    {
      data: {
        type: "Organization",
        id: "#{primary_organization_id}"
      }.ignore_extra_keys!
    }.ignore_extra_keys!
  }

  let(:data_links_pattern) {
    {
      data: {
        links: {
          self: "#{base_url}/organizations/#{primary_organization_id}"
        }
      }.ignore_extra_keys!
    }.ignore_extra_keys!
  }

  context "when requesting the canonical link to the primary organization" do
    it "should respond to the canonical link with the resource" do
      visit "/organizations/#{primary_organization_id}"
      expect(page.body).to match_json_expression(organization_data_pattern)
    end

    it "should have the canonical link within the resource data links object" do
      visit "/organizations/#{primary_organization_id}"
      expect(page.body).to match_json_expression(data_links_pattern)
    end
  end

  context "when requesting the home related organization link" do
    it "should respond to the home related link with the resource" do
      visit '/home/organization'
      expect(page.body).to match_json_expression(organization_data_pattern)
    end

    it "should have the canonical link within the resource data links object" do
      visit '/home/organization'
      expect(page.body).to match_json_expression(data_links_pattern)
    end
  end
end
