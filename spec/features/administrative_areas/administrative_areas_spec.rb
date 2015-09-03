require 'spec_helper'

describe "GET /organizations/:id/administrative_areas/:id", type: :feature do
  it "should successfully respond" do
    get "#{organization_url}/administrative_areas/1"
    expect(last_response.status).to eq(200)
  end

  it "should include the data for an AdministrativeArea" do
    data_pattern = {
      data: {
        type: "AdministrativeArea",
        id: "1",
        links: {
          self: "#{organization_url}/administrative_areas/1"
        },
        attributes: {
          address: {
            address_country: /\w/
          }
        }
      }
    }
    visit "#{organization_url}/administrative_areas/1"
    expect(page.body).to match_json_expression(data_pattern)
  end
end
