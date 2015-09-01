require 'spec_helper'

describe "GET /organizations/:id/contact_points/:id", type: :feature do
  it "should respond not found if ContactPoint does not exist" do
    get "#{organization_url}/contact_points/NON-EXISTENT"
    expect(last_response.status).to eq(404)
  end

  context "when ContactPoint exists" do
    let(:contact_points_collection) { ContactPointsCollection.new }
    let(:contact_point) {
      ContactPoint.new(attributes: {id: 1}, organization: primary_organization)
    }

    before(:each) do
      allow(contact_points_collection).
        to receive(:exists?).with(contact_point.id).and_return(true)
    end

    it "should respond successfully" do
      get "#{organization_url}/contact_points/#{contact_point.id}"
      expect(last_response.status).to eq(200)
    end

    it "should contain a links object" do
      links_pattern = {
        links: {
          self: "#{organization_url}/contact_points/#{contact_point.id}"
        }
      }.ignore_extra_keys!
      visit "#{organization_url}/contact_points/#{contact_point.id}"
      expect(page.body).to match_json_expression(links_pattern)
    end

    it "should contain a data object" do
      data_pattern = {
        data: {
          type: "ContactPoint",
          id: "1",
          links: {
            self: "#{organization_url}/contact_points/#{contact_point.id}",
          },
          attributes: {
            areaServed: [],
            phoneNumber: ""
          }
        }
      }.ignore_extra_keys!
      visit "#{organization_url}/contact_points/#{contact_point.id}"
      expect(page.body).to match_json_expression(data_pattern)
    end
  end
end
