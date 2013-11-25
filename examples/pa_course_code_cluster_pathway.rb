# usage: ruby pa_course_code_cluster_pathway.rb
#
# courses with clusters/pathways by (deprecated) program areas
require 'csv'
require 'verso'

puts CSV.generate_line(%w{ Program\ Area Title Code Cluster Pathway })

Verso::ProgramAreaList.new.each do |pa|
  pa.courses.each do |course|
    course.occupation_data.each do |od|
      puts CSV.generate_line(
        [pa.title, course.title, course.code,
         od.cluster.title, od.pathway.title]
      )
    end
  end
end
