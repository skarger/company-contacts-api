require_relative '../spec_helper.rb'

describe "public contact points endpoint", type: :feature do
  it "should respond with a 200 to the organization related link" do
    get "#{organization_url}/public_contact_points"
    expect(last_response.status).to eq(200)
  end
end
