require_relative '../spec_helper'

describe "home page related links", type: :feature do
  base_url = "http://localhost:3000"
  it "should successfully respond to the related organization link" do
    get '/home/organization'
    expect(last_response.status).to eq(200)
  end

  it "should respond with the overall organization content" do
    cp = ContentPreparer.new
    visit '/home/organization'
    expect(page.body).to eq(cp.organization_data)
  end
end
