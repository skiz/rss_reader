require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Entry do
  
  before(:each) do
    @elements = {
      :title => 'Testing Feed',
      :description => 'This is a test',
      :images => [
          'http://example.com/image1.jpg',
          'http://example.com/image2.jpg'],
      :created_on => 'Thu, 03 Dec 2009 19:48:45 GMT',
      :permalink => 'http://example.com/permalink/1.html'
    }
  end
  
  it "should handle initialization with a hash" do
    e = Entry.new(@elements)
    e.title.should eql(@elements[:title])
    e.description.should eql(@elements[:description])
    e.images.should eql(@elements[:images])
    e.created_on.should eql(@elements[:created_on])
    e.permalink.should eql(@elements[:permalink])
  end
  
  it "should create methods for each accessor" do
    e = Entry.new(@elements)
    @elements.each do |k,v|
      e.should respond_to("#{k}".to_sym)
    end
  end
end