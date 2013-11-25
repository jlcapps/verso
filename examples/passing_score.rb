# usage: ruby passing_score.rob
#
# list of credentials with passing score where available
require 'csv'
require 'verso'

puts CSV.generate_line(['Title', 'Source', 'Passing Score'])
Verso::CredentialList.new.each do |cred|
  unless (cred.passing_score.to_s.empty? ||
          cred.passing_score.to_s =~ /contact/i)
    puts CSV.generate_line([cred.title, cred.source.title, cred.passing_score])
  end
end
