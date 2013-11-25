# usage: ruby hs_v_ms.rb

require 'csv'
require 'verso'

Verso::CourseList.new.sort_by { |c| c.title + c.code }.each do |course|
  puts CSV.generate_line(
    ["#{course.title} (#{course.code})",
     course.is_ms? && !course.is_hs? ? "MIDDLE" : "HIGH"]
  )
end
