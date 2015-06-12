require_relative "./spec_helper.rb"
require 'rack/test'

include Rack::Test::Methods

describe "server responsibility" do
  def app
    CompanyContactsApi
  end

  it "should send the Content-Type for JSON API" do
    content_type = "application/vnd.api+json"
    get '/'
    expect(last_response.header['Content-Type']).to eq(content_type)
  end

  context "when the request media type is application/vnd.api+json" do
    it "should respond with 415 if request specifies media type parameters" do
      request_media_type = "application/vnd.api+json; version=1.0"
      header 'Content-Type', request_media_type
      get '/'
      expect(last_response.status).to eq(415)
    end
  end

  context "when the request media type is not application/vnd.api+json" do
    it "should not care if request specifies media type parameters" do
      request_media_type = "text/plain; charset=utf-8"
      header 'Content-Type', request_media_type
      get '/'
      expect(last_response.status).to_not eq(415)
    end
  end

end

