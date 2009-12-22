module Erector
  class External < Struct.new(:type, :text, :options)
    def initialize(type, text, options = {})
      text = External.interpolate(text.read) if text.is_a? IO
      super(type.to_sym, text, options)
    end
    
    def self.interpolate(s)
      eval("<<INTERPOLATE\n" + s + "\nINTERPOLATE").chomp
    end
    
    def ==(other)
      (self.type == other.type and
      self.text == other.text and
      self.options == other.options) ? true : false
    end
  end
  
end
