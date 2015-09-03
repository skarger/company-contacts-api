require 'spec_helper'

describe Authorizer do
  describe "#logged_in?" do
    it "should refuse access by default" do
      expect(Authorizer.new.logged_in?).to be false
    end
  end
end
