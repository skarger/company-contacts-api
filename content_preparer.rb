require 'json'

module Configuration
  def base_url
    "http://localhost:3000"
  end
end

class OrganizationCollection
  def initialize
    @organization_ids = [1]
  end

  def resource_identifier_array
    @organization_ids.map do |id|
      organization = Organization.new
      {
        type: organization.type,
        id: organization.id.to_s
      }
    end
  end

  def resource_objects
    @organization_ids.map do |id|
      Organization.new.data
    end
  end
end

class Organization
  include Configuration

  attr_reader :type, :id

  def initialize
    @type = "Organization"
    @id = 1
  end

  def url
    "#{base_url}/organizations/#{@id}"
  end

  def data
    {
      type: @type,
      id: @id.to_s,
      links: {
        self: "#{url}"
      },
      relationships: {
        public_contact_points: {
          links: {
            self: "#{url}/relationships/public_contact_points",
            related: "#{url}/public_contact_points"
          }
        },
        member_facing_contact_points: {
          links: {
            self: "#{url}/relationships/member_facing_contact_points",
            related: "#{url}/member_facing_contact_points"
          }
        },
        administrative_areas: {
          links: {
            self: "#{url}/relationships/administrative_areas",
            related: "#{url}/administrative_areas"
          }
        }
      }
    }
  end
end

module ContentPreparer
  include Configuration

  def administrative_area_id_US
    1
  end

  def administrative_area_id_CA
    2
  end

  def primary_organization
    Organization.new
  end

  def primary_organization_id
    primary_organization.id
  end

  def organization_url
    primary_organization.url
  end

  def primary_organization_links
    {
      links: {
        self: "#{Organization.new.url}"
      }
    }
  end

  def primary_organization_content
    organizations = OrganizationCollection.new
    primary_organization_data = organizations.resource_objects[0]
    JSON.pretty_generate(
      primary_organization_links.merge({data: primary_organization_data})
    )
  end

  def organization_public_contact_points_relationship_content
    <<-RESPONSE.gsub /^\s{4}/, ''
    {
      "links": {
        "self": "#{organization_url}/relationships/public_contact_points",
        "related": "#{organization_url}/public_contact_points"
      },
      "data": [{
        "type": "ContactPoint",
        "id": "1"
      }]
    }
    RESPONSE
  end

  def organization_administrative_areas_relationship_content
    <<-RESPONSE.gsub /^\s{4}/, ''
    {
      "links": {
        "self": "#{organization_url}/relationships/administrative_areas",
        "related": "#{organization_url}/administrative_areas"
      },
      "data": [{
        "type": "AdministrativeArea",
        "id": "#{administrative_area_id_US}"
      },
      {
        "type": "AdministrativeArea",
        "id": "#{administrative_area_id_CA}"
      }]
    }
    RESPONSE
  end

  def home_page_related_organization_links
    {
      links: {
        self: "#{base_url}/home/organizations"
      }
    }
  end

  def home_related_organization_content
    data = OrganizationCollection.new.resource_objects
    JSON.pretty_generate(
      home_page_related_organization_links.merge({data: data})
    )
  end

  def home_organization_relationship_content
    organizations = OrganizationCollection.new
    <<-RESPONSE.gsub /^\s{4}/, ''
    {
      "links": {
        "self": "#{base_url}/home/relationships/organizations",
        "related": "#{base_url}/home/organizations"
      },
      "data": #{JSON.pretty_generate(organizations.resource_identifier_array)}
    }
    RESPONSE
  end

  def administrative_areas_collection_data
    {
      data: [
        {
          type: "AdministrativeArea",
          id: "#{administrative_area_id_US}",
          links: {
            self: "#{organization_url}/administrative_areas/#{administrative_area_id_US}"
          }
        },
        {
          type: "AdministrativeArea",
          id: "#{administrative_area_id_CA}",
          links: {
            self: "#{organization_url}/administrative_areas/#{administrative_area_id_CA}"
          }
        }
      ]
    }
  end

  def administrative_areas_collection_links
    {
      links: {
        self: "#{organization_url}/administrative_areas"
      }
    }
  end

  def administrative_area_collection_content
    JSON.pretty_generate(
      administrative_areas_collection_links.
        merge(administrative_areas_collection_data)
    )
  end

  def home_page_content
    <<-RESPONSE.gsub /^\s{4}/, ''
    {
      "links": {
        "self": "#{base_url}/home"
      },
      "data": {
        "type": "WebPage",
        "id": "1",
        "links": {
            "self": "#{base_url}/home"
        },
        "attributes": {
          "description": "Organizational Contact Points"
        },
        "relationships": {
          "organizations": {
            "links": {
              "self": "#{base_url}/home/relationships/organizations",
              "related": "#{base_url}/home/organizations"
            }
          }
        }
      }
    }
    RESPONSE
  end

  class ContactPoint
    attr_reader :id, :area_served, :phone_number

    def initialize(id, area_served, phone_number)
      @id = id
      @area_served = area_served
      @phone_number = phone_number
    end
  end

  def serialize_contact_point(contact_point)
    {
      type: "ContactPoint",
      id: "#{contact_point.id}",
      links: {
        self: "#{organization_url}/contact_points/#{contact_point.id}"
      },
      attributes: {
        areaServed: contact_point.area_served,
        phoneNumber: contact_point.phone_number
      }
    }
  end

  def organization_public_contact_points_content
    contact_point_US = ContactPoint.new(1, ["US"], "1-866-123-4567")
    contact_point_CA = ContactPoint.new(2, ["CA"], "1-866-987-6543")
    contact_point_GB = ContactPoint.new(3, ["GB"], "44 1234 567")
    response = {
      links:  {
          "self":  "#{organization_url}/public_contact_points"
      },
      data: [
        serialize_contact_point(contact_point_US),
        serialize_contact_point(contact_point_CA),
        serialize_contact_point(contact_point_GB)
      ]
    }
    JSON.pretty_generate(response)
  end
end
