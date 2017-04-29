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

  def chars?
    self.split("").map{|x| ([*"a".."z"] + [*"A".."Z"] + [" "]).include?(x)}.reduce(:&)
  end
end

subcmd = ARGV[0]
animals = []
case subcmd
when "animalist"
  animals = Animalist::animalist(61,1)

  CSV.open("animals.csv", "wb") do |csv|
    animals.select{|x| x[0].utf8?}.each{|animal| csv << animal}
  end
when "univbooks"
  books = UnivLab::univbooks(27,1)

  CSV.open("univbooks.csv", "wb") do |csv|
    books.each { |book| csv << book }
  end
when "filter"
  file_name = ARGV[1] == nil ? "animals.csv" : ARGV[1]
  char_len = ARGV[2] == nil ? 10 : ARGV[2].to_i
  CSV.foreach(file_name) do |row|
    animal = row[1].split
    # animals << animal.map(&:downcase) if animal.length <= 2 && animal.join("").chars?
    animals << [animal.join("").downcase, row[0], row[2]] if animal.length <= 2 && animal.join("").chars?
  end
  CSV.open("animals_filter.csv", "wb") do |csv|
    animals.select{|x| x[0].length <= char_len}.uniq{|x| x[0]}.sort.each{|animal| csv << animal}
  end
when "filter_stdout"
  file_name = ARGV[1] == nil ? "animals.csv" : ARGV[1]
  char_len = ARGV[2] == nil ? 10 : ARGV[2].to_i
  CSV.foreach(file_name) do |row|
    animal = row[1].split
    animals << animal if animal.length <= 2 && animal.join("").chars?
  end
  puts animals.map{|x| x.join("").downcase}.select{|x| x.length <= 10}.uniq.sort
when "chars_stdout"
  file_name = ARGV[1] == nil ? "animals.csv" : ARGV[1]
  char_len = ARGV[2] == nil ? 10 : ARGV[2].to_i
  CSV.foreach(file_name) do |row|
    animal = row[1].split
    animals << animal if animal.length <= 2 && animal.join("").chars?
  end
  tmp = animals.flatten.sort
  puts tmp.uniq.map {|x| [tmp.select{|y| x == y}.length, x]}.sort{|x,y| y <=> x}.select{|x| x[0] > 1}.map{|x| x.to_s}
else
  puts "#{subcmd} is no much subcommand."
end



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
