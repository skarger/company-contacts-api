class ContactPointPresenter
  def initialize(contact_point)
    @contact_point = contact_point
  end

  def url
    "#{base_url}" +
    "/organizations/#{@contact_point.organization_id}" +
    "/contact_points/#{@contact_point.id}"
  end

  def resource_identifier
    {
      type: "ContactPoint",
      id: "#{@contact_point.id}"
    }
  end

  def resource_object
    {
      type: "ContactPoint",
      id: "#{@contact_point.id}",
      links: {
        self: url
      },
      attributes: {
        areaServed: @contact_point.area_served,
        phoneNumber: @contact_point.phone_number
      }
    }
  end
end

