#!/usr/bin/env ruby
class InstanceEval
  attr_accessor :v
  def initialize
    @v = 1
  end  
end

obj = InstanceEval.new
obj.instance_eval {
  puts self
  puts @v
}
v = 5 #local_variable

puts "local_variables: #{local_variables}"

obj.instance_eval {
  puts "local_variables within instance_eval: #{local_variables}"  
  puts "instance_variables within instance_eval: #{instance_variables}"

  @v = v
}
obj.instance_eval {puts @v}
