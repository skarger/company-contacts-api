dev = ENV['RACK_ENV'] == 'development'
require 'rack/unreloader'
Unreloader = Rack::Unreloader.new(:reload=>dev){CompanyContactsApi}
require 'roda'
Unreloader.require './company_contacts_api.rb'
run (dev ? Unreloader : CompanyContacsApi)
