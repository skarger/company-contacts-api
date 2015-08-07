require_relative "../spec_helper.rb"

describe "organization relationships", type: :feature do
  describe "public contact points relationship" do
    it "should return 200" do
      get "#{organization_url}/relationships/public_contact_points"
      expect(last_response.status).to eq(200)
    end

    it "should return have a links object for the relationship" do
      links_pattern = {
        links: {
          self: "#{organization_url}/relationships/public_contact_points",
          related: "#{organization_url}/public_contact_points"
        }
      }.ignore_extra_keys!
      visit "#{organization_url}/relationships/public_contact_points"
      expect(JSON.parse(page.body)).to match_json_expression(links_pattern)
    end

    it "should return have a data object for the relationship" do
      data_pattern = {
        data: [{
          type: "ContactPoint",
          id: "1"
        }]
      }.ignore_extra_keys!
      visit "#{organization_url}/relationships/public_contact_points"
      expect(JSON.parse(page.body)).to match_json_expression(data_pattern)
    end
  end

  describe "administrative_areas relationship" do
    it "should return 200 for the administrative_areas relationship" do
      get "#{organization_url}/relationships/administrative_areas"
      expect(last_response.status).to eq(200)
    end

    it "should have a links object for the administrative_areas relationship" do
      links_pattern = {
        links: {
          self: "#{organization_url}/relationships/administrative_areas",
          related: "#{organization_url}/administrative_areas"
        }
      }.ignore_extra_keys!
      visit "#{organization_url}/relationships/administrative_areas"
      expect(JSON.parse(page.body)).to match_json_expression(links_pattern)
    end

    it "should have a data object for the administrative_areas relationship" do
      data_pattern = {
        data: [{
          type: "AdministrativeArea",
          id: "1"
        },
        {
          type: "AdministrativeArea",
          id: "2"
        }]
      }.ignore_extra_keys!
      visit "#{organization_url}/relationships/administrative_areas"
      expect(JSON.parse(page.body)).to match_json_expression(data_pattern)
    end
  end
end

