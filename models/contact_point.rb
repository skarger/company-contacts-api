class ContactPoint
  attr_reader :id, :area_served, :contact_type, :phone_number, :email

  class NullOrganization
    attr_reader :id

    def initialize
      @id = -1
    end
  end
  
  def initialize(attributes: {}, organization: nil)
    defaults = {
      id: -1,
      contact_type: "",
      area_served: [],
      phone_number: "",
      email: ""
    }
    attributes = defaults.merge(attributes)

    @id = attributes[:id]
    @contact_type = attributes[:contact_type]
    @area_served = attributes[:area_served]
    @phone_number = attributes[:phone_number]
    @email = attributes[:email]
    @organization = organization ||= NullOrganization.new
  end

  def organization_id
    @organization.id
  end

end

