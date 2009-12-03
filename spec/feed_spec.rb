require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Feed do

  before(:each) do
    @feed = Feed.new('http://example.com/feed.rss')
    @feed.stub!(:open).and_return(File.read('spec/example.rss'))
  end
  
  describe "handling urls" do
    
    it "should set the feed url" do
      @feed.url.should eql('http://example.com/feed.rss')
    end
    
    it "should raise InvalidUrl exception on bad url" do
      lambda do
        @feed = Feed.new('bad!')
        @feed.fetch
      end.should raise_error(InvalidUrl)
    end
    
    it "should raise InvalidUrl on SocketError" do
      lambda do
        @feed = Feed.new('implicit socket error!')
        @feed.should_receive(:open).and_raise(SocketError)
        @feed.fetch
      end.should raise_error(InvalidUrl)
    end
  end
  
  describe "parsing main rss" do
    
    before(:each) do
      @feed.fetch
    end
    
    it "should have data available" do
      @feed.rss.should_not be_nil
    end

    it "should set the copyright if available" do
      @feed.copyright.should eql('Copyright (c) 2009 Yahoo! Inc. All rights reserved.')
    end
    
    it "should set the title if available" do
      @feed.title.should eql('Yahoo! News: Top Stories')
    end
    
    it "should create entries for each item" do
      @feed.entries.should_not be_nil, "No entries were created from feed!"
      @feed.entries.size.should eql(20)
    end
  end
  
  describe "parsing single items" do
    
    before(:each) do
      @feed.stub!(:open).and_return(File.read('spec/example_single.rss'))
      @feed.fetch
      @entry = @feed.entries.first
    end
    
    it "should set the title" do
      @entry.title.should eql('Senate casts first votes to overhaul health care (AP)')
    end
    
    it "should set the source" do
      @entry.source.should eql('AP')
    end
    
    it "should set the category" do
      @entry.category.should eql('business')
    end
      
  end
end