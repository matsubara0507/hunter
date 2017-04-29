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

books = UnivLab::univbooks(27,1)

CSV.open("univbooks.csv", "wb") do |csv|
  books.each { |book| csv << book }
end
