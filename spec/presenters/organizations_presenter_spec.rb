require 'spec_helper'

describe OrganizationsPresenter do
  let(:organization) { Organization.new }
  it "should be instantiable" do
    expect(OrganizationsPresenter.new([organization])).to be
  end

  describe "#resource_identifiers" do
    it "should return an array of resource identifiers" do
      presenter = OrganizationsPresenter.new([organization])
      expect(presenter.resource_identifiers).to eq([{
        type: "Organization",
        id: "1"
      }])
    end
  end
end
