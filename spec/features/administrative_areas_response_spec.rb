require_relative '../spec_helper.rb'

describe "administrative_areas endpoint", type: :feature do
  let(:administrative_area_id_US) { 1 }
  let(:administrative_area_id_CA) { 2 }

    let(:administrative_area_data_pattern) {
    {
      data: [
        {
          type: "AdministrativeArea",
          id: "#{administrative_area_id_US}"
        }.ignore_extra_keys!,
        {
          type: "AdministrativeArea",
          id: "#{administrative_area_id_CA}"
        }.ignore_extra_keys!
      ]
    }.ignore_extra_keys!
  }

  let(:data_links_pattern) {
    {
      data: [
        {
          links: {
            self: "#{organization_url}/administrative_areas/#{administrative_area_id_US}"
          }
        }.ignore_extra_keys!,
        {
          links: {
            self: "#{organization_url}/administrative_areas/#{administrative_area_id_CA}"
          }
        }.ignore_extra_keys!
      ]
    }.ignore_extra_keys!
  }

  context "when requesting the canonical AdministrativeAreas collection" do
    it "should respond to the canonical link with the resource" do
      visit "#{organization_url}/administrative_areas"
      expect(page.body).to match_json_expression(administrative_area_data_pattern)
    end

    it "should have the item links within the resource individual objects" do
      visit "#{organization_url}/administrative_areas"
      expect(page.body).to match_json_expression(data_links_pattern)
    end
  end

  context "when requesting the organization related administrative_areas link" do
    it "should respond with the administrative_areas collection" do
      visit "#{organization_url}/administrative_areas"
      expect(page.body).to match_json_expression(administrative_area_data_pattern)
    end

    it "should have the item links within the resource individual objects" do
      visit "#{organization_url}/administrative_areas"
      expect(page.body).to match_json_expression(data_links_pattern)
    end
  end
end
