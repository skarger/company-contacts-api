require 'json'

module ContentPreparer
  def base_url
    "http://localhost:3000"
  end

  def primary_organization_id
    1
  end

  def administrative_area_id_US
    1
  end

  def administrative_area_id_CA
    2
  end

  def organization_url
    "#{base_url}/organizations/#{primary_organization_id}"
  end

  def organization_data
    {
      data: {
        type: "Organization",
        id: "#{primary_organization_id}",
        links: {
          self: "#{base_url}/organizations/#{primary_organization_id}"
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
    }
  end

  def primary_organization_links
    {
      links: {
        self: "#{organization_url}"
      }
    }
  end

  def primary_organization_content
    JSON.pretty_generate(
      primary_organization_links.merge(organization_data)
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
        self: "#{base_url}/home/organization"
      }
    }
  end

  def home_related_organization_content
    JSON.pretty_generate(
      home_page_related_organization_links.merge(organization_data)
    )
  end

  def home_organization_relationship_content
    <<-RESPONSE.gsub /^\s{4}/, ''
    {
      "links": {
        "self": "#{base_url}/home/relationships/organization",
        "related": "#{base_url}/home/organization"
      },
      "data": {
        "type": "Organization",
        "id": "#{primary_organization_id}"
      }
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
          "organization": {
            "links": {
              "self": "#{base_url}/home/relationships/organization",
              "related": "#{base_url}/home/organization"
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
