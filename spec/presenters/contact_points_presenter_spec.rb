require 'spec_helper'

describe "ContactPointsPresenter" do
  let(:contact_point) {
    ContactPoint.new(
      attributes: {id: 123, area_served: ["US"], phone_number: "867-5309"}
    )
  }

  it "should be instantiable" do
    expect(ContactPointsPresenter.new).to be
  end

  it "should accept a list of ContactPoint objects to contain" do
      contact_points_presenter = ContactPointsPresenter.new(
        [contact_point]
      )
      expect(contact_points_presenter).to be
  end

  describe "#resource_objects" do
    it "should return an Array" do
      contact_points_presenter = ContactPointsPresenter.new([])
      expect(contact_points_presenter.resource_objects).to be_kind_of(Array)
    end

    context "when there are no ContactPoints in this collection" do
      it "should return an empty array" do
        contact_points_presenter = ContactPointsPresenter.new([])
        resource_objects = contact_points_presenter.resource_objects
        expect(resource_objects).to eq([])
      end
    end

    context "when there are ContactPoints in this collection" do
      let(:contact_point_one) { contact_point }
      let(:contact_point_two) { contact_point }
      let(:cp_array) { [contact_point_one, contact_point_two] }

      it "should include the ContactPointPresenter resource objects" do
        contact_points_presenter = ContactPointsPresenter.new(cp_array)
        resource_objects = contact_points_presenter.resource_objects
        expect(resource_objects).to include(
          ContactPointPresenter.new(contact_point_one).resource_object
        )
        expect(resource_objects).to include(
          ContactPointPresenter.new(contact_point_two).resource_object
        )
      end
    end
  end

  describe "resource_identifiers" do
    context "when there are no ContactPoints in this collection" do
      it "should return an empty array" do
        contact_points_presenter = ContactPointsPresenter.new([])
        expect(contact_points_presenter.resource_identifiers).to eq([])
      end
    end

    context "when there are ContactPoints in this collection" do
      let(:contact_point_one) { contact_point }
      let(:contact_point_two) { contact_point }
      let(:cp_array) { [contact_point_one, contact_point_two] }

      it "should include the ContactPointPresenter resource identifiers" do
        contact_points_presenter = ContactPointsPresenter.new(cp_array)
        resource_identifiers = contact_points_presenter.resource_identifiers
        expect(resource_identifiers).to include(
          ContactPointPresenter.new(contact_point_one).resource_identifier
        )
        expect(resource_identifiers).to include(
          ContactPointPresenter.new(contact_point_two).resource_identifier
        )
      end
    end
  end
end
