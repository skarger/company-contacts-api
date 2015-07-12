require 'rspec'
require 'json_expressions/rspec'
require 'capybara/rspec'
require_relative '../company_contacts_api.rb'
require_relative '../content_preparer.rb'

include ContentPreparer
Capybara.app = CompanyContactsApi 
