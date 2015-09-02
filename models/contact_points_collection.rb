module ContactPointsCollection

  def initialize
    @all_contact_points = []
    @ids = []
  end

  def contains?(id)
    @ids.include?(id)
  end

  def all
    @all_contact_points
  end
end
