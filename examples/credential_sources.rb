# usage: ruby credential_sources.rb
#

require 'csv'
require 'verso'

puts CSV.generate_line(%w(Credential Source Contractor))
Verso::CredentialList.new.each do |cred|
  puts CSV.generate_line([cred.title, cred.source.title, cred.contractor_name])
end
