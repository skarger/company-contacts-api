require 'rack/test'
require 'rspec'
require 'capybara/rspec'
require 'json_expressions/rspec'

$LOAD_PATH.unshift File.join(File.dirname(__FILE__), '../')
require 'dependencies'

include ContentPreparer

module RackTestHelper
  def self.included(mod)
    mod.include Rack::Test::Methods
  end

  # for capybara feature tests
  Capybara.app = OrganizationalContactsApi

  # for rack tests
  def app
    OrganizationalContactsApi
  end
end
