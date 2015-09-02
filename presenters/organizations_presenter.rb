class OrganizationsPresenter
  def initialize(organizations)
    @organizations = organizations
  end

  def resource_identifiers
    @organizations.map do |organization|
      presenter = OrganizationPresenter.new(organization)
      presenter.resource_identifier
    end
  end

  def resource_objects
    @organizations.map do |organization|
      presenter = OrganizationPresenter.new(organization)
      presenter.resource_object
    end
  end
end

