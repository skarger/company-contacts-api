require_relative "./spec_helper.rb"

describe "server responsibility" do
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

  context "when a request's Accept header contains the JSON API media type" do
      let(:no_media_parameter) { "application/vnd.api+json" }
      media_parameter_v1 = "application/vnd.api+json; version=1.0"
      media_parameter_v2 = "application/vnd.api+json; version=2.0"
      context "when all instances are modified with media type parameters" do
        request_accept = "#{media_parameter_v1}, #{media_parameter_v2}"
        it "should respond with a 406" do
          header 'Accept', request_accept
          get '/'
          expect(last_response.status).to eq(406)
        end
      end

      context "when at least one instance is not modified with media type parameters" do
        it "should not respond with a 406" do
          request_accept = "#{media_parameter_v1}, #{no_media_parameter}"
          header 'Accept', request_accept
          get '/'
          expect(last_response.status).to_not eq(406)
        end
      end
    end
end

