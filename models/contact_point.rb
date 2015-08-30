class ContactPoint
  attr_reader :id, :area_served, :phone_number

  class NullOrganization
    attr_reader :id

    def initialize
      @id = -1
    end
  end
  
  def initialize(attributes: {}, organization: nil)
    defaults = {
      id: -1,
      area_served: [],
      phone_number: ""
    }
    attributes = defaults.merge(attributes)

    @id = attributes[:id]
    @area_served = attributes[:area_served]
    @phone_number = attributes[:phone_number]
    @organization = organization ||= NullOrganization.new
  end

  def organization_id
    @organization.id
  end

end

