class AdministrativeAreasPresenter
  def initialize(administrative_areas = [])
    @administrative_areas = administrative_areas
  end

  def resource_objects
    @administrative_areas.map do |area|
      area.resource_object
    end
  end

  def resource_identifiers
    @administrative_areas.map do |area|
      area.resource_identifier
    end
  end
end
