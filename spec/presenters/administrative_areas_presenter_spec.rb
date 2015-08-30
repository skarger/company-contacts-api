require 'spec_helper'

describe "AdministrativeAreasPresenter" do
  it "should be instantiable" do
    expect(AdministrativeAreasPresenter.new).to be
  end

  it "should accept a list of AdministrativeArea objects to contain" do
      administrative_areas = AdministrativeAreasPresenter.new(
        [AdministrativeAreaPresenter.new]
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
      let(:area_one) { AdministrativeAreaPresenter.new }
      let(:area_two) { AdministrativeAreaPresenter.new }
      let(:area_array) { [area_one, area_two] }

      it "should include the AdministrativeArea resource objects" do
        administrative_areas = AdministrativeAreasPresenter.new(area_array)
        resource_objects = administrative_areas.resource_objects
        expect(resource_objects).to include(area_one.resource_object)
        expect(resource_objects).to include(area_two.resource_object)
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
      let(:area_one) { AdministrativeAreaPresenter.new }
      let(:area_two) { AdministrativeAreaPresenter.new }
      let(:area_array) { [area_one, area_two] }

      it "should include the AdministrativeArea resource identifiers" do
        administrative_areas = AdministrativeAreasPresenter.new(area_array)
        resource_identifiers = administrative_areas.resource_identifiers
        expect(resource_identifiers).to include(area_one.resource_identifier)
        expect(resource_identifiers).to include(area_two.resource_identifier)
      end
    end
  end
end
