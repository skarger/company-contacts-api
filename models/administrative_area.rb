class AdministrativeArea
  attr_reader :id, :contained_in, :address

  def initialize(id: nil, organization: nil, contained_in: nil, address: {})
    @id = id

    if organization.nil?
      @organization = Organization.new
    else
      @organization = organization
    end

    if contained_in.nil?
      @contained_in = default_containing_area
    else
      @contained_in = contained_in
    end

    @address = address
  end

  def organization_id
    @organization.id
  end

  private

  class TopLevelAdministrativeArea
    attr_reader :address, :contained_in

    def initialize
      @address = {}
      @contained_in = nil
    end
  end

  def default_containing_area
    AdministrativeArea.new(contained_in: TopLevelAdministrativeArea.new)
  end
end
