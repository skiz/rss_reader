$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rubygems'
require 'nokogiri'
require 'open-uri'

require 'rss_reader/errors'
require 'rss_reader/feed'
require 'rss_reader/entry'
