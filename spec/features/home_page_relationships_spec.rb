require_relative "../spec_helper.rb"

require 'rack/test'

include Rack::Test::Methods

def app
  CompanyContactsApi
end

def base_url
  "http://localhost:3000"
end

describe "home page relations", type: :feature do
  base_url = "http://localhost:3000"

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

  describe "place relationship" do
    it "should return 200 for the place relationship" do
      get '/home/relationships/place'
      expect(last_response.status).to eq(200)
    end

    it "should return have a links object for the place relationship" do
      links_pattern = {
        links: {
          self: "#{base_url}/home/relationships/place",
          related: "#{base_url}/home/place"
        }
      }.ignore_extra_keys!
      visit '/home/relationships/place'
      expect(JSON.parse(page.body)).to match_json_expression(links_pattern)
    end

    it "should return have a data object for the place relationship" do
      data_pattern = {
        data: {
          type: "Place",
          id: "1"
        }
      }.ignore_extra_keys!
      visit '/home/relationships/place'
      expect(JSON.parse(page.body)).to match_json_expression(data_pattern)
    end
  end
end

