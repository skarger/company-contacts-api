require 'spec_helper'

describe "member facing contact points endpoint", type: :feature do
  include RackTestHelper

  context "when not logged in" do
    it "should respond with a 403 to the link" do
      allow_any_instance_of(Authorizer).to receive(:logged_in?).and_return(false)
      get "#{organization_url}/member_facing_contact_points"
      expect(last_response.status).to eq(403)
    end
  end

  context "when logged in" do
    class TestAuthorizer
      def logged_in?
        true
      end
    end

    before(:each) do
      allow(Authorizer).to receive(:new).and_return(TestAuthorizer.new)
    end

    it "should respond with a 200 to the link" do
      get "#{organization_url}/member_facing_contact_points"
      expect(last_response.status).to eq(200)
    end

    it "should have a links object" do
      top_level_links_pattern = {
        links: {
          self: "#{organization_url}/member_facing_contact_points"
        }
      }.ignore_extra_keys!
      visit "#{organization_url}/member_facing_contact_points"
      expect(page.body).to match_json_expression(top_level_links_pattern)
    end

    it "should have a data object with a collection of ContactPoint values" do

      contact_point_US = ContactPoint.new(
        attributes: {
          id: 1,
          area_served: ["US"],
          contact_type: "customer service",
          email: "service@example.com",
          phone_number: "1-866-123-4567"
        },
        organization: primary_organization
      )
      contact_point_CA = ContactPoint.new(
        attributes: {
          id: 2,
          area_served: ["CA"],
          contact_type: "customer service",
          email: "service@example.ca",
          phone_number: "1-866-987-6543"
        },
        organization: primary_organization
      )
      contact_point_GB = ContactPoint.new(
        attributes: {
          id: 3,
          area_served: ["GB"],
          contact_type: "customer service",
          email: "service@example.co.uk",
          phone_number: "44 1234 567"
        },
        organization: primary_organization
      )
      data_collection_pattern = {
        data: [
          ContactPointPresenter.new(contact_point_US).resource_object,
          ContactPointPresenter.new(contact_point_CA).resource_object,
          ContactPointPresenter.new(contact_point_GB).resource_object
        ]
      }.ignore_extra_keys!
      visit "#{organization_url}/member_facing_contact_points"
      expect(page.body).to match_json_expression(data_collection_pattern)
    end
  end
end
