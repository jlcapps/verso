# usage: ruby cpo.rb
require 'csv'
require 'verso'

puts CSV.generate_line(%w(Occupation Pathway Cluster))
ods = Verso::OccupationList.new(:text => '*')
ods.each do |od|
  od.occupations.each do |o|
    puts CSV.generate_line [o.title, od.pathway.title, od.cluster.title]
  end
end
