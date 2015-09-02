require_relative '../configuration'

class Organization
  include Configuration

  attr_reader :type, :id

  def initialize
    @type = "Organization"
    @id = 1
  end

  def url
    "#{base_url}/organizations/#{@id}"
  end

  def data
    {
      type: @type,
      id: @id.to_s,
      links: {
        self: "#{url}"
      },
      relationships: {
        public_contact_points: {
          links: {
            self: "#{url}/relationships/public_contact_points",
            related: "#{url}/public_contact_points"
          }
        },
        member_facing_contact_points: {
          links: {
            self: "#{url}/relationships/member_facing_contact_points",
            related: "#{url}/member_facing_contact_points"
          }
        },
        administrative_areas: {
          links: {
            self: "#{url}/relationships/administrative_areas",
            related: "#{url}/administrative_areas"
          }
        }
      }
    }
  end
end
