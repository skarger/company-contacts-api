require_relative '../spec_helper'

describe "home page related links", type: :feature do
  it "should successfully respond to the related organization link" do
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
