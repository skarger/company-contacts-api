require_relative "../spec_helper.rb"

describe "home page relations", type: :feature do
  describe "organization relationship" do
    it "should return 200 for the organization relationship" do
      get '/home/relationships/organization'
      expect(last_response.status).to eq(200)
    end

    it "should return have a links object for the organization relationship" do
      links_pattern = {
        links: {
          self: "#{base_url}/home/relationships/organization",
          related: "#{base_url}/home/organization"
        }
      }.ignore_extra_keys!
      visit '/home/relationships/organization'
      expect(JSON.parse(page.body)).to match_json_expression(links_pattern)
    end

    it "should return have a data object for the organization relationship" do
      data_pattern = {
        data: {
          type: "Organization",
          id: "1"
        }
      }.ignore_extra_keys!
      visit '/home/relationships/organization'
      expect(JSON.parse(page.body)).to match_json_expression(data_pattern)
    end
  end

  describe "administrative_areas relationship" do
    it "should return 200 for the administrative_areas relationship" do
      get '/home/relationships/administrative_areas'
      expect(last_response.status).to eq(200)
    end

    it "should have a links object for the administrative_areas relationship" do
      links_pattern = {
        links: {
          self: "#{base_url}/home/relationships/administrative_areas",
          related: "#{base_url}/home/administrative_areas"
        }
      }.ignore_extra_keys!
      visit '/home/relationships/administrative_areas'
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
      visit '/home/relationships/administrative_areas'
      expect(JSON.parse(page.body)).to match_json_expression(data_pattern)
    end
  end
end

