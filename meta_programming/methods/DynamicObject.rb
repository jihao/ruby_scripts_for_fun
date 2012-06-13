#!/usr/bin/env ruby
class DynamicObject < Object
  def initialize
    @attributes={}
  end
  def method_missing(methId,*args)
    puts "You called: #{methId}(#{args.join(', ')})"
    puts "(You also passed it a block)" if block_given?
    # variable = get_instance_variable_name methId
    # puts "#{methId.id2name} -> #{variable}"
    # -------- THE FOLLOWING WAY DOES NOT WORK ----------------
    # attr_accessor variable, this way is not working, cause recourisive stack error
    # send variable, *args
    
     if methId.to_s =~ /(\w+)=$/
       @attributes[$1] = args[0]
     else
       @attributes[methId.to_s]
     end

  end
  
  private 
  def get_instance_variable_name(sym)
    match = sym.id2name.match(/^(\w+)=$/)
    match.nil? ? sym : match[1].to_sym 
  end
end

o = DynamicObject.new
puts "o.not_exist.nil? : #{o.not_exist.nil?}"
o.var1 = "value of var1"
puts o.inspect