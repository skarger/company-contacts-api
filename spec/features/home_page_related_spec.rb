require_relative '../spec_helper'

describe "home page related links", type: :feature do
  it "should successfully respond to the related organization link" do
    get '/home/organization'
    expect(last_response.status).to eq(200)
  end

  it "should respond with the overall organization content" do
    organization_data_pattern = {
      data: {
        type: "Organization",
        id: "1"
      }.ignore_extra_keys!
    }.ignore_extra_keys!
    visit '/home/organization'
    expect(page.body).to match_json_expression(organization_data_pattern)
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

  it "should have a links object within the resource with the canonical link" do
    data_links_pattern = {
      data: {
        links: {
          self: "#{base_url}/organizations/1"
        }
      }.ignore_extra_keys!
    }.ignore_extra_keys!
    visit '/home/organization'
    expect(page.body).to match_json_expression(data_links_pattern)
  end
end
