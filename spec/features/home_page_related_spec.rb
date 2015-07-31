require_relative '../spec_helper'

describe "home page related links", type: :feature do
  context 'related organization link' do
    it "should successfully respond" do
      get '/home/organization'
      expect(last_response.status).to eq(200)
    end

    it "should have a links object with the related organization link" do
      top_level_links_pattern = {
        links: {
          self: "#{base_url}/home/organization"
        }
      }.ignore_extra_keys!
      visit '/home/organization'
      expect(page.body).to match_json_expression(top_level_links_pattern)
    end
  end

  context "related administrative_areas link" do
    it "should successfully respond the the related administrative_areas link" do
      get '/home/administrative_areas'
      expect(last_response.status).to eq(200)
    end

    it "should have a links object with a link to itself" do
      top_level_links_pattern = {
        links: {
          self: "#{base_url}/home/administrative_areas"
        }
      }.ignore_extra_keys!
      visit '/home/administrative_areas'
      expect(page.body).to match_json_expression(top_level_links_pattern)
    end
  end
end
