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
    JSON.pretty_generate({
      links: {
        self: "#{base_url}/home"
      },
      data: {
        type: "WebPage",
        id: "1",
        links: {
            self: "#{base_url}/home"
        },
        attributes: {
          description: "Organizational Contact Points"
        },
        relationships: {
          organizations: {
            links: {
              self: "#{base_url}/home/relationships/organizations",
              related: "#{base_url}/home/organizations"
            }
          }
        }
      }
    })
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

  def administrative_area_US
    AdministrativeArea.new(id: 1, address: { address_country: "US" })
  end

  def administrative_area_CA
    AdministrativeArea.new(id: 2, address: { address_country: "CA" })
  end

  def administrative_area_GB
    AdministrativeArea.new(id: 3, address: { address_country: "GB" })
  end

  def all_administrative_areas
    [administrative_area_US, administrative_area_CA, administrative_area_GB]
  end

  def organization_administrative_areas_relationship_content
    presenter = AdministrativeAreasPresenter.new(all_administrative_areas)
    presenter.resource_identifiers
    JSON.pretty_generate({
      links: {
        self: "#{organization_url}/relationships/administrative_areas",
        related: "#{organization_url}/administrative_areas"
      }
    }.merge({data: presenter.resource_identifiers}))
  end

  def administrative_areas_collection_data
    {
      data: all_administrative_areas.map do |area|
        AdministrativeAreaPresenter.new(area).resource_object
      end
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

  def administrative_area_content(id)
    area = all_administrative_areas.select { |element|
      element.id == id
    }.first
    JSON.pretty_generate({
      data: AdministrativeAreaPresenter.new(area).resource_object
    })
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
