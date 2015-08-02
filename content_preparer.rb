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
          }
        }
      }
    }
  end

  def primary_organization_links
    {
      links: {
        self: "#{base_url}/organizations/#{primary_organization_id}"
      }
    }
  end

  def primary_organization_content
    JSON.pretty_generate(
      primary_organization_links.merge(organization_data)
    )
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
            self: "#{base_url}/administrative_areas/#{administrative_area_id_US}"
          }
        },
        {
          type: "AdministrativeArea",
          id: "#{administrative_area_id_CA}",
          links: {
            self: "#{base_url}/administrative_areas/#{administrative_area_id_CA}"
          }
        }
      ]
    }
  end

  def administrative_areas_collection_links
    {
      links: {
        self: "#{base_url}/administrative_areas"
      }
    }
  end

  def administrative_area_collection_content
    JSON.pretty_generate(
      administrative_areas_collection_links.
        merge(administrative_areas_collection_data)
    )
  end

  def home_page_related_administrative_area_links
    {
      links: {
        self: "#{base_url}/home/administrative_areas"
      }
    }
  end

  def home_related_administrative_areas_content
    JSON.pretty_generate(
      home_page_related_administrative_area_links.
        merge(administrative_areas_collection_data)
    )
  end

  def home_administrative_areas_relationship_content
    <<-RESPONSE.gsub /^\s{4}/, ''
    {
      "links": {
        "self": "#{base_url}/home/relationships/administrative_areas",
        "related": "#{base_url}/home/administrative_areas"
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
            },
            "data": { "type": "Organization", "id": "#{primary_organization_id}" }
          },
          "administrative_areas": {
            "links": {
              "self": "#{base_url}/home/relationships/administrative_areas",
              "related": "#{base_url}/home/administrative_areas"
            },
            "data": [
              { "type": "AdministrativeArea", "id": "#{administrative_area_id_US}" },
              { "type": "AdministrativeArea", "id": "#{administrative_area_id_CA}" }
            ]
          }
        }
      }
    }
    RESPONSE
  end
end
