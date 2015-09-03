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
          self: organization_url
        },
        attributes: {
        },
        relationships: {
          public_contact_points: {
            links: {
              self: "#{organization_url}/relationships/public_contact_points",
              related: "#{organization_url}/public_contact_points"
            }
          },
          member_facing_contact_points: {
            links: {
              self: "#{organization_url}/relationships/member_facing_contact_points",
              related: "#{organization_url}/member_facing_contact_points"
            }
          },
          administrative_areas: {
            links: {
              self: "#{organization_url}/relationships/administrative_areas",
              related: "#{organization_url}/administrative_areas"
            }
          }
        }
      }
      organization_presenter = OrganizationPresenter.new(organization)
      expect(organization_presenter.resource_object).to eq(expected_data)
    end
  end
end
