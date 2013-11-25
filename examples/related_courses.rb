#usage: ruby related_courses.rb
#
# list of each course and the codes of its related courses
require 'csv'
require 'verso'

puts CSV.generate_line(%w{ Code Title Related\ Courses })

Verso::CourseList.new.each do |course|
  puts CSV.generate_line(
    [course.code, course.title,
     course.related_courses.collect { |c| c.code }.join(' ')]
  )
end
