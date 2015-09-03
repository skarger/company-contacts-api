require 'spec_helper'

describe AdministrativeArea do
  describe "#initialize" do
    it "should be instantiable" do
      expect(AdministrativeArea.new).to be
    end

    it "should accept an id" do
      expect(AdministrativeArea.new(id: 1)).to be
    end

    it "should accept a contained_in AdministrativeArea" do
      containing_area = AdministrativeArea.new
      expect(AdministrativeArea.new(contained_in: containing_area)).to be
    end

    it "should accept an address hash" do
      expect(AdministrativeArea.new(address: { address_country: "US" })).to be
    end

    it "should accept an affiliated Organization" do
      expect(AdministrativeArea.new(organization: Organization.new)).to be
    end
  end

  describe "#address" do
    it "should return a hash with PostalAdress attributes" do
      address_hash = { address_country: "US" }
      administrative_area = AdministrativeArea.new(address: address_hash)
        expect(administrative_area.address).to eq({ address_country: "US" })
    end

    it "should return the hash passed to the initializer if present" do
      address_hash = {
        address_country: "CA",
        address_locality: "Toronto",
        address_region: "ON"
      }
      expect(AdministrativeArea.new(address: address_hash).address).to eq({
        address_country: "CA",
        address_locality: "Toronto",
        address_region: "ON"
      })
    end
  end

  describe "#contained_in" do
    it "should return an AdministrativeArea" do
      expect(AdministrativeArea.new.contained_in).
        to be_kind_of(AdministrativeArea)
    end

    it "should return the passed in contained AdministrativeArea if given" do
      contained_in = AdministrativeArea.new(address: { address_country: "US" })
      administrative_area = AdministrativeArea.new(
        contained_in: contained_in,
        address: {
          address_country: "US",
          address_locality: "Boston",
          address_region: "MA"
      })
      expect(administrative_area.contained_in).to eq(contained_in)
    end
  end
end
