require 'spec_helper'

describe OrganizationPresenter do
  let(:organization) { Organization.new }

  describe "#resource_identifier" do
    it "should return a hash with type and id fields" do
      organization_presenter = OrganizationPresenter.new(organization)
      expect(organization_presenter.resource_identifier).to eq({
        type: "Organization",
        id: "1"
      })
    end
  end

  describe "#resource_object" do
    it "should return a hash with the appropriate attributes" do
      expected_data = {
        type: "Organization",
        id: "1",
        links: {
          self: "#{base_url}/organizations/#{organization.id}"
        },
        attributes: {
        }
      }
      organization_presenter = OrganizationPresenter.new(organization)
      expect(organization_presenter.resource_object).to eq(expected_data)
    end
  end
end
