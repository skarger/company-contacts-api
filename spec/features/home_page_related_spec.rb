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
      }
    }
    visit '/home/organization'
    expect(page.body).to match_json_expression(organization_data_pattern)
  end
end
