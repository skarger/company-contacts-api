require 'spec_helper'

class ExampleCollection
  include ContactPointsCollection

  def initialize
    attributes_US = {id: 1, area_served: ["US"], phone_number: "1-866-123-4567"}
    contact_point_US = ContactPoint.new(
      attributes: attributes_US,
      organization: primary_organization
    )
    @all_contact_points = [contact_point_US]
    @ids = [1]
  end
end

describe ContactPointsCollection do
  describe "#contains?" do
    it "should return false if given a non-existent id" do
      contact_points_collection = ExampleCollection.new
      expect(contact_points_collection.contains?("FAKE")).to be false
    end

    it "should return true if given an existent id" do
      contact_points_collection = ExampleCollection.new
      expect(contact_points_collection.contains?(1)).to be true
    end
  end

  describe "#all" do
    it "should return an empty array until overriden" do
      class EmptyCollection
        include ContactPointsCollection
      end
      expect(EmptyCollection.new.all).to eq([])
    end
  end
end
