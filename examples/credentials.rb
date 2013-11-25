# usage: ruby credentials.rb

require 'csv'
require 'verso'

puts CSV.generate_line(
  %w{ Title Description Source Contractor Related\ Courses }
)

Verso::CredentialList.new.each do |cred|
  puts CSV.generate_line(
    [cred.title,
     cred.description.
       gsub(/<\/?[^>]*>/, "").
       strip.
       gsub(/\r\n/, " | ").
       gsub(/&[a-zA-Z]+;/, " "),
     cred.source.title,
     cred.contractor_name,
     cred.
       related_courses.
         collect { |c| "#{c.title} (#{c.code})" }.
         join('; ')]
  )
end
