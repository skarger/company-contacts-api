require 'spec_helper'

describe "primary organization endpoint", type: :feature do
  include RackTestHelper

  it "should successfully respond to the canonical organization link" do
    get organization_url
    expect(last_response.status).to eq(200)
  end

  let(:top_level_links_pattern) {
    {
      links: {
        self: /#{base_url}\/organizations\/\d/
      }
    }.ignore_extra_keys!
  }

  let(:organization_data_pattern) {
    {
      data: {
        type: "Organization",
        id: "#{primary_organization_id}"
      }.ignore_extra_keys!
    }.ignore_extra_keys!
  }

  let(:organization_data_links_pattern) {
    {
      data: {
        links: {
          self: "#{organization_url}"
        }
      }.ignore_extra_keys!
    }.ignore_extra_keys!
  }

  let(:organization_data_relationships_pattern) {
    {
      data: {
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
      }.ignore_extra_keys!
    }.ignore_extra_keys!
  }

  it "should have a link to itself at the top level" do
    visit "/organizations/#{primary_organization.id}"
    expect(page.body).to match_json_expression(top_level_links_pattern)
  end

  it "should respond to the canonical link with the resource" do
    visit organization_url
    expect(page.body).to match_json_expression(organization_data_pattern)
  end

  it "should have the canonical link within the resource data links object" do
    visit organization_url
    expect(page.body).to match_json_expression(organization_data_links_pattern)
  end

  it "should have a link to contact points within the data relationships" do
    visit organization_url
    expect(page.body).to match_json_expression(organization_data_relationships_pattern)
  end
end
