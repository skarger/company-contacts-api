require 'spec_helper'

describe "AdministrativeAreasPresenter" do
  let(:administrative_area) {
    AdministrativeArea.new(id: 1, address: { address_country: "US" })
  }

  let(:area_presenter_one) {
    AdministrativeAreaPresenter.new(administrative_area)
  }

  let(:area_presenter_two) {
    AdministrativeAreaPresenter.new(administrative_area)
  }

  let(:area_array) { [administrative_area, administrative_area] }

  it "should be instantiable" do
    expect(AdministrativeAreasPresenter.new(administrative_area)).to be
  end

  it "should accept a list of AdministrativeArea objects to contain" do
      administrative_areas = AdministrativeAreasPresenter.new(
        [AdministrativeAreaPresenter.new(administrative_area)]
      )
      expect(administrative_areas).to be
  end

  describe "#resource_objects" do
    it "should return an Array" do
      administrative_areas = AdministrativeAreasPresenter.new([])
      expect(administrative_areas.resource_objects).to be_kind_of(Array)
    end

    context "when there are no AdministrativeAreas in this collection" do
      it "should return an empty array" do
        administrative_areas = AdministrativeAreasPresenter.new([])
        resource_objects = administrative_areas.resource_objects
        expect(resource_objects).to eq([])
      end
    end

    context "when there are AdministrativeAreas in this collection" do
      it "should include the AdministrativeArea resource objects" do
        administrative_areas = AdministrativeAreasPresenter.new(area_array)
        resource_objects = administrative_areas.resource_objects
        expect(resource_objects).
          to include(area_presenter_one.resource_object)
        expect(resource_objects).
          to include(area_presenter_two.resource_object)
      end
    end
  end

  describe "resource_identifiers" do
    context "when there are no AdministrativeAreas in this collection" do
      it "should return an empty array" do
        administrative_areas = AdministrativeAreasPresenter.new([])
        expect(administrative_areas.resource_identifiers).to eq([])
      end
    end

    context "when there are AdministrativeAreas in this collection" do

      it "should include the AdministrativeArea resource identifiers" do
        administrative_areas = AdministrativeAreasPresenter.new(area_array)
        resource_identifiers = administrative_areas.resource_identifiers
        expect(resource_identifiers).
          to include(area_presenter_one.resource_identifier)
        expect(resource_identifiers).
          to include(area_presenter_two.resource_identifier)
      end
    end
  end
end
