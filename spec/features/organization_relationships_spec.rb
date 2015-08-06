require_relative "../spec_helper.rb"

describe "organization relationships", type: :feature do
  describe "public contact points relationship" do

    it "should return 200" do
      get '/organizations/1/relationships/public_contact_points'
      expect(last_response.status).to eq(200)
    end

    it "should return have a links object for the relationship" do
      links_pattern = {
        links: {
          self: "#{base_url}/organizations/1/relationships/public_contact_points",
          related: "#{base_url}/organizations/1/public_contact_points"
        }
      }.ignore_extra_keys!
      visit '/organizations/1/relationships/public_contact_points'
      expect(JSON.parse(page.body)).to match_json_expression(links_pattern)
    end

    it "should return have a data object for the relationship" do
      data_pattern = {
        data: [{
          type: "ContactPoint",
          id: "1"
        }]
      }.ignore_extra_keys!
      visit '/organizations/1/relationships/public_contact_points'
      expect(JSON.parse(page.body)).to match_json_expression(data_pattern)
    end
  end
end

