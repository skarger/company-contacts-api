class AdministrativeAreaPresenter
  include Configuration

  def initialize(administrative_area)
    @administrative_area = administrative_area
  end

  def url
    "#{base_url}/organizations/#{@administrative_area.organization_id}" +
      "/administrative_areas/#{@administrative_area.id}"
  end

  def resource_object
    {
      type: "AdministrativeArea",
      id: "#{@administrative_area.id}",
      links: {
        self: url
      },
      attributes: {
        address: @administrative_area.address
     }
    }
  end

  def resource_identifier
    {
      type: "AdministrativeArea",
      id: "#{@administrative_area.id}"
    }
  end
end

