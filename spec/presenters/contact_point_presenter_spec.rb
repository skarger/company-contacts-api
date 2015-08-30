require 'spec_helper'

describe ContactPointPresenter do
  describe "#resource_identifier" do
    let(:org) { Organization.new }
    let(:contact_point) {
      ContactPoint.new(1, ["US"], "1-866-123-4567", org)
    }

    it "should return a hash with type and id fields" do
      contact_point_presenter = ContactPointPresenter.new(contact_point)
      expect(contact_point_presenter.resource_identifier).to eq({
        type: "ContactPoint",
        id: "1"
      })
    end

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
          phoneNumber: "1-866-123-4567"
        }
      }
      contact_point_presenter = ContactPointPresenter.new(contact_point)
      expect(contact_point_presenter.resource_object).to eq(expected_data)
    end
  end
end
