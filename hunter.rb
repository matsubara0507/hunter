# coding: utf-8
require "csv"
require "./lib/animalist"
require "./lib/univ"

# animals = Animalist::animalist(61,1)
#
# CSV.open("animals.csv", "wb") do |csv|
#   animals.each { |animal| csv << animal }
# end
#

# books = UnivLab::univbooks(27,1)
#
# CSV.open("univbooks.csv", "wb") do |csv|
#   books.each { |book| csv << book }
# end

animals = []
CSV.foreach("animals.csv") do |row|
  animal = row[1]
  animals << row if animal.split.length <= 2
end

CSV.open("animals_filter_name_2.csv", "wb") do |csv|
  animals.each { |animal| csv << animal }
end
