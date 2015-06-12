require 'roda'

class CompanyContactsApi < Roda
  route do |r|
    base_url = "http://localhost:3000"
    response['Content-Type'] = 'application/vnd.api+json'

    r.root do
      if request.media_type == 'application/vnd.api+json' && !request.media_type_params.empty?
        response.status = 415
      else
        r.redirect "/home"
      end
    end

    r.on "home" do
      <<-RESPONSE.gsub /^\s{6}/, ''
      {
        "links": {
            "self": "#{base_url}/home"
        },
        "data": [{
          "relationships": {
            "organization": {
              "links": {
                "self": "#{base_url}/relationships/organization",
                "related": "#{base_url}/organization"
              }
            }
          }
        }]
      }
      RESPONSE
    end
  end

end

