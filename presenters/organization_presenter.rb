class OrganizationPresenter
  include Configuration

  def initialize(organization)
    @organization = organization
  end

  def url
    "#{base_url}/organizations/#{@organization.id}"
  end

  def resource_identifier
    {
      type: "Organization",
      id: "#{@organization.id}"
    }
  end

  def resource_object
    {
      type: "Organization",
      id: "#{@organization.id}",
      links: {
        self: url
      },
      attributes: {
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

