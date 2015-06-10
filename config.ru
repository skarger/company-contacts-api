require 'roda'

class CompanyContactsApi < Roda
  route do |r|
    r.get do
      "hello"
    end
  end
end

run CompanyContactsApi

