# coding: utf-8
require "csv"
require "./lib/animalist"
require "./lib/univ"

class String
  def utf8?
    begin
      self.split("")
      return true
    rescue ArgumentError
      return false
    end
  end
end

animals = Animalist::animalist(61,1)

CSV.open("animals.csv", "wb") do |csv|
  animals.select{|x| x[0].utf8?}.each{|animal| csv << animal}
end


# books = UnivLab::univbooks(27,1)
#
# CSV.open("univbooks.csv", "wb") do |csv|
#   books.each { |book| csv << book }
# end

# animals = []
# CSV.foreach("animals.csv") do |row|
#   animal = row[1].split
#   animals << [animal.join("").downcase, row[0], row[2]] if animal.length <= 2
# end
#
# CSV.open("animals_filter_lower.csv", "wb") do |csv|
#   animals.select do |name, title, ref|
#     name.split("").map{|x| [*"a".."z"].include?(x)}.reduce(:&)
#   end.each{|animal| csv << animal}
# end

# url = 'https://www.oreilly.co.jp/catalog/'
# charset = nil
# html = open(url) do |f|
#   charset = f.charset
#   f.read
# end
# doc = Nokogiri::HTML.parse(html, nil, charset)
# doc.xpath('//td[@class="title"]').map do |node|
#   isbm = node.css('a').attribute('href').value
#   ref = node.css('a').attribute('href').value
#   title_isbm = get_title_isbm(ref)
#   [title_isbm[0], ref, title_isbm[1]]
# end.select { |title, ref, isbm| isbm != "" }
