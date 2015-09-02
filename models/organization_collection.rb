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

