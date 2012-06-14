#!/usr/bin/env ruby
class DynamicObject
  def initialize
    @attributes={}
  end
  def method_missing(methId,*args)
    puts "You called: #{methId}(#{args.join(', ')})"
    puts "(You also passed it a block)" if block_given?
    
    if self.respond_to?(methId) 
      puts "I am going to respond to your call '#{methId}'"
      __send__(methId,*args)
    else
      super
    end
  end
  
  def respond_to? (method)
    puts "the respond_to? was called on '#{method}'"
    if !super
      puts "super doesn't respond, so I dynamically define_method"
      variable = get_instance_variable_name(method.to_sym)
      
      DynamicObject.send :define_method, variable.to_s.concat("=").to_sym, proc {|arg|
        puts "Status before = ",self.inspect
        instance_variable_set "@".concat(variable.to_s),arg
        puts "Status after = ",self.inspect
        
      }
      DynamicObject.send :define_method, variable.to_sym, proc {
        puts "Status before = ",self.inspect
        instance_variable_get "@".concat(variable.to_s)
        puts "Status after = ",self.inspect
      }
      puts "define_method finished, return true"
      true
    else
      super  
    end
  end
  private 
  def get_instance_variable_name(sym)
    match = sym.id2name.match(/^(\w+)=$/)
    match.nil? ? sym : match[1].to_sym 
  end
end

o = DynamicObject.new
#puts (o.respond_to? :abc)
o.abc = "will this work?"
puts o.abc
o.not_exist_attr = "I love ruby"
puts o.inspect