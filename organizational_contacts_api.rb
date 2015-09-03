require 'bundler/setup'
require 'roda'
require './models'
require './content_preparer'

class OrganizationalContactsApi < Roda
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
        r.is "organizations" do
          home_organization_relationship_content
        end
      end

      r.is "organizations" do
        home_related_organization_content
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

      r.is "public_contact_points" do
        organization_public_contact_points_content
      end

      r.is "member_facing_contact_points" do
        if Authorizer.new.logged_in?
           organization_member_facing_contact_points_content
        else
          response.status = 403
        end
      end

      r.is "contact_points/:id" do |id|
        if PublicContactPointsCollection.new.contains?(id.to_i)
          contact_point_content(id.to_i)
        else
          response.status = 404
        end
      end

      r.on "administrative_areas" do
        r.is do
          administrative_area_collection_content
        end

        r.is ":id" do |id|
          if [1,2,3].include?(id.to_i)
            administrative_area_content(id.to_i)
          else
            response.status = 404
          end
        end
      end

      r.on "relationships" do
        r.is "public_contact_points" do
          organization_public_contact_points_relationship_content
        end

        r.is "member_facing_contact_points" do
          if Authorizer.new.logged_in?
            organization_member_facing_contact_points_relationship_content
          else
            response.status = 403
          end
        end

        r.is "administrative_areas" do
          organization_administrative_areas_relationship_content
        end
      end
    end

  end

end

