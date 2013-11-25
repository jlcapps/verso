# usage: ruby ceop.rb
#
# dumps CSV list of courses wth cluster, pathway, occupation information in CSV
# format.

require 'csv'
require 'verso'

puts CSV.generate_line(%w{ Title Code Edition Cluster Pathway Occupation })

Verso::CourseList.new.each do |c|
  c.occupation_data.each do |od|
    od.occupations.each do |occupation|
      puts CSV.generate_line(
        [c.title, c.code, c.edition, od.cluster.title,
         od.pathway.title, occupation.title]
      )
    end
  end
end
