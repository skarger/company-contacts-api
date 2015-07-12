require 'json'

module ContentPreparer
  def organization_data
    organization_data = {
      data: {
        type: "Organization",
        id: "1"
      }
    }
    JSON.generate(organization_data)
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


  def home_place_relationship_content
    <<-RESPONSE.gsub /^\s{4}/, ''
    {
      "links": {
          "self": "#{base_url}/home/relationships/place",
          "related": "#{base_url}/home/place"
      },
      "data": {
        "type": "Place",
        "id": "1"
      }
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
        "attributes": {
          "description": "Organizational Contact Points"
        },
        "relationships": {
          "organization": {
            "type": "Organization",
            "id": "1",
            "links": {
              "self": "#{base_url}/home/relationships/organization",
              "related": "#{base_url}/home/organization"
            },
            "data": { "type": "Organization", "id": "1" }
          },
          "place": {
            "type": "Place",
            "id": "1",
            "links": {
              "self": "#{base_url}/home/relationships/place",
              "related": "#{base_url}/home/place"
            },
            "data": { "type": "Place", "id": "1" }
          }
        }
      }
    }
    RESPONSE
  end
end
