require 'spec_helper'

describe ContactPointsCollection do
  describe "#contains?" do
    it "should return false if given a non-existent id" do
      contact_points_collection = ContactPointsCollection.new
      expect(contact_points_collection.contains?("FAKE")).to be false
    end

    it "should return true if given an existent id" do
      contact_points_collection = ContactPointsCollection.new
      expect(contact_points_collection.contains?(1)).to be true
    end
  end
end
