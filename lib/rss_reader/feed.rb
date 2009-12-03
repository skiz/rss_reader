class RssReader::Feed
  attr_accessor :url, :rss, :entries, :title, :copyright
  
  def initialize(url)
    @url = url
  end
  
  def fetch
    @rss ||= open(url)
    parse_feed
    yield @entries if block_given?
  rescue Errno::ENOENT, SocketError
    raise InvalidUrl
  end
  
  protected
  
  def parse_feed
    @entries = []
    doc = Nokogiri::HTML(@rss)
    @title     = doc.xpath('//title').first.text
    @copyright = doc.xpath('//copyright').text
    doc.xpath('//item').each do |item|
      @entries << Entry.new(
        item.children.inject({}) do |result, element|
          result[element.name.to_sym] = element.text
          result
        end
      )
    end
  end
  
end
