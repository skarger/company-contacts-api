require 'spec_helper'

describe "AdministrativeAreaPresenter" do
  it "should be instantiable" do
    expect(AdministrativeAreaPresenter.new).to be
  end

  describe "#resource_object" do
    it "should return a hash with resource object elements" do
      object_hash = {
        type: "AdministrativeArea",
        id: "1"
      }
      area = AdministrativeAreaPresenter.new
      expect(area.resource_object).to eq(object_hash)
    end
  end

  describe "#resource_identifier" do
    it "should return a hash with type and id" do
      identifier_hash = {
        type: "AdministrativeArea",
        id: "1"
      }
      area = AdministrativeAreaPresenter.new
      expect(area.resource_identifier).to eq(identifier_hash)
    end
  end
end
