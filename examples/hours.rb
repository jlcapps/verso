# usage: ruby hours.rb NN

require 'csv'
require 'verso'

hours =  ARGV[0].to_i
Verso::CourseList.new.
  select { |c| c.hours == hours }.
  sort_by { |c| c.title }.
  each do |course|
    puts CSV.generate_line [course.title, course.code]
end
