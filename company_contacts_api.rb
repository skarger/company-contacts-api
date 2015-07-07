require 'roda'

class CompanyContactsApi < Roda
  def base_url
    "http://localhost:3000"
  end

  def json_api_media_type
    'application/vnd.api+json'
  end

  def home_page_description
    "Welcome to our Organizational Contact Points home page. Follow the links to explore a directory of contact info."
  end

  def content_type_valid?(request)
    request.media_type_params.empty? || request.media_type != json_api_media_type
  end

  def matches_json_api_media_type(accept_header_media_type)
    Regexp.new(Regexp.escape(json_api_media_type)).match(accept_header_media_type)
  end

  def accept_header_valid?(request)
    accept_header = request.env["HTTP_ACCEPT"]
    if !accept_header
      return true
    end

    accepted_media_types = accept_header.split(",")
    contains_json_api_media_type = false
    all_instances_have_media_type_parameters = true

    accepted_media_types.each do |media_type|
      media_type = media_type.strip
      if matches_json_api_media_type(media_type)
        contains_json_api_media_type = true
        if json_api_media_type == media_type
          all_instances_have_media_type_parameters = false
        end
      end
    end

    if contains_json_api_media_type && all_instances_have_media_type_parameters
      return false
    else
      return true
    end
  end

  route do |r|
    response['Content-Type'] = json_api_media_type

    if !content_type_valid?(request)
      response.status = 415
    elsif !accept_header_valid?(request)
        response.status = 406
    end

    if response.status
      r.halt
    end

    r.root do
      r.redirect "/home"
    end

    r.on "home" do
      <<-RESPONSE.gsub /^\s{6}/, ''
      {
        "links": {
            "self": "#{base_url}/home"
        },
        "data": [{
          "type": "WebPage",
          "id": 1,
          "attributes": {
            "mainContentOfPage": "#{home_page_description}"
          },
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

