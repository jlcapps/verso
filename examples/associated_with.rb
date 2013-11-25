# usage: ruby associated_with.rb 'Title of a Standard'
#
# e.g., ruby associated_with.rb 'Science' # => all courses associated with
# the Science standards body.

require 'csv'
require 'verso'

standard = ARGV[0] || 'Science'

puts CSV.generate_line(%w{ Code Title }) + "\n"

Verso::CourseList.new.each do |c|
  if c.standards.find { |c| c.title == standard }
    puts CSV.generate_line([c.code, c.title])
  end
end
