require 'spec_helper'

describe ContactPointPresenter do
  let(:contact_point) {
    ContactPoint.new(attributes: {
      id: 1,
      area_served: ["US"],
      contact_type: "customer service",
      email: "service@example.com",
      phone_number: "1-866-123-4567"
    })
  }

  describe "#resource_identifier" do
    it "should return a hash with type and id fields" do
      contact_point_presenter = ContactPointPresenter.new(contact_point)
      expect(contact_point_presenter.resource_identifier).to eq({
        type: "ContactPoint",
        id: "1"
      })
    end
  end

  describe "#resource_object" do
    it "should return a hash with the appropriate attributes" do
      expected_data = {
        type: "ContactPoint",
        id: "1",
        links: {
          self: "#{base_url}" +
            "/organizations/#{contact_point.organization_id}" +
            "/contact_points/#{contact_point.id}"
        },
        attributes: {
          areaServed: ["US"],
          contactType: "customer service",
          email: "service@example.com",
          phoneNumber: "1-866-123-4567"
        }
      }
      contact_point_presenter = ContactPointPresenter.new(contact_point)
      expect(contact_point_presenter.resource_object).to eq(expected_data)
    end
  end
end
