# see https://github.com/jeremyevans/rack-unreloader
in_development_mode = ENV['RACK_ENV'] == 'development'
require 'rack/unreloader'
options = { reload: in_development_mode, subclasses: %w'Roda' }
Unreloader = Rack::Unreloader.new(options){CompanyContactsApi}
Unreloader.require './content_preparer.rb'
Unreloader.require './presenters/*.rb'
Unreloader.require './company_contacts_api.rb'
run (in_development_mode ? Unreloader : CompanyContacsApi)
