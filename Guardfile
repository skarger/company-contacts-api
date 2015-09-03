# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard :rspec, verion: 2, cmd: 'bundle exec rspec' do 
  watch(%r{^spec/.+_spec\.rb$})
  watch('organizational_contacts_api.rb') { "spec" }
  watch('content_preparer.rb') { "spec" }
  watch(%r{^presenters/(.+)\.rb$})     { |m| "spec/presenters/#{m[1]}_spec.rb" }
  watch(%r{^models/(.+)\.rb$})     { |m| "spec/models/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb') { "spec" }
end

