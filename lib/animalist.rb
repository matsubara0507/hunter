require 'open-uri'
require 'nokogiri'

module Animalist
  $animals_url = 'http://www.oreilly.com/animals.csp?x-search=;x-sort=animal&x-o='

  def self.make_animalist(url)
    charset = nil
    html = open(url) do |f|
      charset = f.charset
      f.read
    end
    doc = Nokogiri::HTML.parse(html, nil, charset)
    doc.xpath('//div[@class="animal-row"]').map do |node|
      title = node.css('h1').inner_text
      animal = node.css('h2').inner_text
      ref = node.css('a').attribute('href').value
      [title, animal, ref]
    end
  end

  def self.animalist(n, sleep_time=0)
    [*0..n].map { |i| sleep(sleep_time) ; make_animalist($animals_url + (i*20).to_s)}.reduce(:+)
  end
end
