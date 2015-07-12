require 'rack/test'
require 'rspec'
require 'capybara/rspec'
require 'json_expressions/rspec'

require_relative '../company_contacts_api.rb'
require_relative '../content_preparer.rb'

include ContentPreparer

include Rack::Test::Methods

# for capybara feature tests
Capybara.app = CompanyContactsApi 

# for rack tests
def app
  CompanyContactsApi
end

