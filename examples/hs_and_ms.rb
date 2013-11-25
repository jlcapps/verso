# usage: ruby hs_and_ms.rb

require 'verso'

Verso::CourseList.new.each do |course|
  if course.is_hs? && course.is_ms?
    puts "#{course.title} (#{course.code})"
  end
end
