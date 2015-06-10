require 'capybara/rspec'
require_relative '../company_contacts_api.rb'

Capybara.app = CompanyContactsApi 
