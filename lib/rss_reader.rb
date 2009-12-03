$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rubygems'
require 'nokogiri'
require 'open-uri'

module RssReader
  class InvalidUrl < StandardError ; end
end

require 'rss_reader/feed'
require 'rss_reader/entry'
