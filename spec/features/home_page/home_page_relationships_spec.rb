require 'spec_helper'

describe "home page relations", type: :feature do
  include RackTestHelper

  describe "link to organizations relationship" do
    it "should return 200" do
      get '/home/relationships/organizations'
      expect(last_response.status).to eq(200)
    end

    it "should have a links object" do
      links_pattern = {
        links: {
          self: "#{base_url}/home/relationships/organizations",
          related: "#{base_url}/home/organizations"
        }
      }.ignore_extra_keys!
      visit '/home/relationships/organizations'
      expect(JSON.parse(page.body)).to match_json_expression(links_pattern)
    end

    it "should return a data object with resource identifiers" do
      data_pattern = {
        data: [{
          type: "Organization",
          id: "1"
        }]
      }.ignore_extra_keys!
      visit '/home/relationships/organizations'
      expect(JSON.parse(page.body)).to match_json_expression(data_pattern)
    end
  end
end

