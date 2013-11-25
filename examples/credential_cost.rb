# usage: ruby credential_cost.rb

require 'csv'
require 'verso'

puts CSV.generate_line(['Title', 'cost'])
Verso::CredentialList.new.each do |cred|
  puts CSV.generate_line([cred.title, cred.cost])
end
