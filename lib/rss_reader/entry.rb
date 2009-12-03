module RssReader
  class Entry
    attr_accessor :elements

    def initialize(attrs={})
      @elements = attrs
      @elements.each_key do |method_name|
        (class << self; self; end).class_eval do
         define_method method_name do
           @elements[method_name]
         end
        end
      end
    end
  end
end