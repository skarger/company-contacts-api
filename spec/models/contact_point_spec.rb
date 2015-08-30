require 'spec_helper'

describe ContactPoint do
  describe "#initialize" do
    it "should allow initialization with no arguments" do
      contact_point = ContactPoint.new
      expect(contact_point.id).to be_kind_of(Integer)
      expect(contact_point.area_served).to eq([])
      expect(contact_point.phone_number).to eq("")
    end

    it "should allow initialization with attributes" do
      contact_point = ContactPoint.new(attributes: {id: 123})
      expect(contact_point.id).to eq(123)
    end

    it "should allow initialization with attributes and organization" do
      organization = Organization.new
      contact_point = ContactPoint.new(
        attributes: {id: 123}, organization: organization
      )
      expect(contact_point.id).to eq(123)
      expect(contact_point.organization_id).to eq(organization.id)
    end
  end

  describe "#organization_id" do
    context "when unaffiliated with an organization" do
      it "should return without error"  do
        contact_point = ContactPoint.new()
        expect(contact_point.organization_id).to be_kind_of(Integer)
      end
    end

    context "when affiliated with an organization" do
      it "should return the organization's id"  do
        organization = Organization.new
        contact_point = ContactPoint.new(organization: organization)
        expect(contact_point.organization_id).to eq(organization.id)
      end
    end
  end
end
