require 'spec_helper'

describe "administrative_areas collection endpoint", type: :feature do
  it "should successfully respond to the administrative_areas link" do
    get "#{organization_url}/administrative_areas"
    expect(last_response.status).to eq(200)
  end

  it "should have a link to itself at the top level" do
    top_level_links_pattern = {
      links: {
        self: "#{organization_url}/administrative_areas"
      }
    }.ignore_extra_keys!
    visit "#{organization_url}/administrative_areas"
    expect(page.body).to match_json_expression(top_level_links_pattern)
  end

  let(:administrative_area_id_US) { 1 }
  let(:administrative_area_id_CA) { 2 }
  let(:administrative_area_id_GB) { 3 }

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
        }.ignore_extra_keys!,
        {
          type: "AdministrativeArea",
          id: "#{administrative_area_id_GB}"
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
        }.ignore_extra_keys!,
        {
          links: {
            self: "#{organization_url}/administrative_areas/#{administrative_area_id_GB}"
          }
        }.ignore_extra_keys!
      ]
    }.ignore_extra_keys!
  }

  it "should have a data object with the AdministrativeAreas collection" do
    visit "#{organization_url}/administrative_areas"
    expect(page.body).to match_json_expression(administrative_area_data_pattern)
  end

  it "should have the item links within the resource individual objects" do
    visit "#{organization_url}/administrative_areas"
    expect(page.body).to match_json_expression(data_links_pattern)
  end
end
