require 'spec_helper'

describe "AdministrativeAreaPresenter" do
  let(:administrative_area) {
    AdministrativeArea.new(id: 1, address: { address_country: "US" })
  }

  it "should be instantiable" do
    expect(AdministrativeAreaPresenter.new(administrative_area)).to be
  end

  describe "#resource_object" do
    it "should return a hash with resource object elements" do
      object_hash = {
        type: "AdministrativeArea",
        id: "1",
        links: {
          self: "#{organization_url}/administrative_areas/#{administrative_area.id}"
        },
        attributes: {
          address: { address_country: "US" }
        }
      }
      area = AdministrativeAreaPresenter.new(administrative_area)
      expect(area.resource_object).to eq(object_hash)
    end
  end

  describe "#resource_identifier" do
    it "should return a hash with type and id" do
      identifier_hash = {
        type: "AdministrativeArea",
        id: "1"
      }
      area = AdministrativeAreaPresenter.new(administrative_area)
      expect(area.resource_identifier).to eq(identifier_hash)
    end
  end
end
