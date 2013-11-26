# usage: ruby course_notes.rb

require 'csv'
require 'verso'

Verso::CourseList.new.each do |course|
  unless course.notes.to_s.empty?
    puts CSV.generate_line([course.code, course.title, course.notes])
  end
end
