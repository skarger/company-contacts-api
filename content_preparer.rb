require 'json'

module ContentPreparer
  def base_url
    "http://localhost:3000"
  end

  def organization_data
    {
      data: {
        type: "Organization",
        id: "1",
        links: {
          self: "#{base_url}/organizations/1"
        }
      }
    }
  end

  def primary_organization_links
    {
      links: {
        self: "#{base_url}/organizations/1"
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
        "id": "1"
      }
    }
    RESPONSE
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
        "id": "1"
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
            "data": { "type": "Organization", "id": "1" }
          },
          "administrative_areas": {
            "links": {
              "self": "#{base_url}/home/relationships/administrative_areas",
              "related": "#{base_url}/home/administrative_areas"
            },
            "data": [
              { "type": "AdministrativeArea", "id": "1" }
            ]
          }
        }
      }
    }
    RESPONSE
  end
end
