class ContactPointsPresenter
  def initialize(contact_points = [])
    @contact_points = contact_points
  end

  def resource_objects
    @contact_points.map do |contact_point|
      contact_point.resource_object
    end
  end

  def resource_identifiers
    @contact_points.map do |contact_point|
      contact_point.resource_identifier
    end
  end
end
