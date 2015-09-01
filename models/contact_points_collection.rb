class ContactPointsCollection
  def initialize
    @ids = [1]
  end

  def contains?(id)
    @ids.include?(id)
  end
end

