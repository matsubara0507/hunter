require 'open-uri'
require 'nokogiri'

module UnivLab
  $univlab_url = 'https://opac.lib.gunma-u.ac.jp/opc/xc/search/%2A?os[pub]=%E3%82%AA%E3%83%A9%E3%82%A4%E3%83%AA%E3%83%BC&page='

  def self.url
    $univlab_url
  end

  def self.get_title_isbm(url)
    charset = nil
    html = open(url) do |f|
      charset = f.charset
      f.read
    end

    doc = Nokogiri::HTML.parse(html, nil, charset)
    doc.xpath('//div[@class="mainBox"]').map do |node|
      title = node.css('h3').inner_text
      isbm = node.css('dd').inner_text.split("\n")[-3]
      return [title, isbm == nil ? "" : isbm.chomp]
    end
    return ["",""]
  end

  def self.make_univbooks(url)
    charset = nil
    html = open(url) do |f|
      charset = f.charset
      f.read
    end
    doc = Nokogiri::HTML.parse(html, nil, charset)
    doc.xpath('//td[@class="result"]').map do |node|
      ref = node.css('a').attribute('href').value
      title_isbm = get_title_isbm(ref)
      [title_isbm[0], ref, title_isbm[1]]
    end.select { |title, ref, isbm| isbm != "" }
  end

  def self.univbooks(n, sleep_time=0)
    [*0..n].map { |i| sleep(sleep_time) ; make_univbooks($univlab_url + i.to_s)}.reduce(:+)
  end
end
