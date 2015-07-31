require 'bundler/setup'
require 'roda'
require './content_preparer'

class CompanyContactsApi < Roda
  plugin :param_matchers
  include ContentPreparer

  def json_api_media_type
    'application/vnd.api+json'
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

    r.on :param => 'include' do |value|
      response.status = 400
    end

    r.on :param => 'sort' do |value|
      response.status = 400
    end

    r.on "home" do
      r.is do
        home_page_content
      end

      r.on "relationships" do
        r.is "organization" do
          home_organization_relationship_content
        end

        r.is "administrative_areas" do
          home_administrative_areas_relationship_content
        end
      end

      r.is "organization" do
        home_related_organization_content
      end

      r.is "administrative_areas" do
        home_related_administrative_areas_content
      end

      # handle trailing slash: /home/
      r.is "" do
        r.redirect "/home"
      end
    end

    r.on "organizations/1" do
      r.is do
        primary_organization_content
      end
    end
  end

end

