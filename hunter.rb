require "csv"
require "./lib/animalist"

animals = Animalist::animalist(61,1)

CSV.open("animals.csv", "wb") do |csv|
  animals.each { |animal| csv << animal }
end
