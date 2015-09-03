require 'rack/test'
require 'rspec'
require 'capybara/rspec'
require 'json_expressions/rspec'

require_relative '../organizational_contacts_api.rb'
require_relative '../content_preparer.rb'
require_relative '../models.rb'

include ContentPreparer

include Rack::Test::Methods

# for capybara feature tests
Capybara.app = OrganizationalContactsApi

# for rack tests
def app
  OrganizationalContactsApi
end

