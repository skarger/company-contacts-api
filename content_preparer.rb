require 'json'
require './models'
require './presenters'
require './configuration'

module ContentPreparer
  include Configuration

  def primary_organization
    Organization.new
  end

  def primary_organization_id
    primary_organization.id
  end

  def organization_url
    OrganizationPresenter.new(primary_organization).url
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

  def home_page_related_organization_links
    {
      links: {
        self: "#{base_url}/home/organizations"
      }
    }
  end

  def home_related_organization_content
    data = [primary_organization_data]
    JSON.pretty_generate(
      home_page_related_organization_links.merge({data: data})
    )
  end

  def home_organization_relationship_content
    organizations = OrganizationsPresenter.new([primary_organization])
    top_level_links = {
      links: {
        self: "#{base_url}/home/relationships/organizations",
        related: "#{base_url}/home/organizations"
      }
    }
    JSON.pretty_generate(
      top_level_links.merge({data: organizations.resource_identifiers})
    )
  end

  def primary_organization_links
    {
      links: {
        self: "#{OrganizationPresenter.new(primary_organization).url}"
      }
    }
  end

  def primary_organization_data
    OrganizationPresenter.new(primary_organization).resource_object
  end

  def primary_organization_content
    JSON.pretty_generate(
      primary_organization_links.merge({data: primary_organization_data})
    )
  end

  def organization_public_contact_points_relationship_content
    top_level_links = {
      links: {
        self: "#{organization_url}/relationships/public_contact_points",
        related: "#{organization_url}/public_contact_points"
      }
    }
    contact_points = PublicContactPointsCollection.new.all
    contact_points_presenter = ContactPointsPresenter.new(contact_points)
    JSON.pretty_generate(
      top_level_links.merge({data: contact_points_presenter.resource_identifiers})
    )
  end

  def organization_public_contact_points_content
    response_data = {
      links:  {
          "self":  "#{organization_url}/public_contact_points"
      }
    }
    contact_points = PublicContactPointsCollection.new.all
    contact_points_presenter = ContactPointsPresenter.new(contact_points)
    JSON.pretty_generate(
      response_data.merge({data: contact_points_presenter.resource_objects})
    )
  end

  def administrative_area_id_US
    1
  end

  def administrative_area_id_CA
    2
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

  def contact_point_content(id)
    contact_point = ContactPoint.new(
      attributes: {id: id}, organization: primary_organization
    )
    presenter = ContactPointPresenter.new(contact_point)
    JSON.pretty_generate({
      links: {
          self: presenter.url
        }
    }.merge({
      data: presenter.resource_object
    }))
  end

end
