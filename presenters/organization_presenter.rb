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
      }
    }
  end
end

