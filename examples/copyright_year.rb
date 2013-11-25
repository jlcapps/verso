# usage: ruby copyright_year.rb
#

require 'csv'
require 'verso'

puts CSV.generate_line(
  %w(Program\ Area Title Code Copyright Related\ Resources)
)
courses = Verso::CourseList.new
courses.sort_by { |course| course.title }.each do |course|
  course.attrs[:program_areas].each do |pa|
    puts CSV.generate_line [
      pa,
      course.title,
      course.code,
      course.frontmatter ? course.frontmatter.copyright_year : '',
      course.related_resources.join(', ')
    ]
  end
end
