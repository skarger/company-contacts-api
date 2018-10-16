require 'configuration'
require 'content_preparer'

$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__), 'presenters/')
Dir['presenters/*'].each { |file| require file }

$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__), 'models/')
Dir['models/*'].each { |file| require file }

require 'organizational_contacts_api'
