#!/usr/bin/env ruby
v1 = 1
class MyClass
  v2 = 2
  puts "#{__LINE__}, #{local_variables}"
  
  def my_method
    v3 = 3
    puts "#{__LINE__}, #{local_variables}"
  end
  
  puts "#{__LINE__}, #{local_variables}"
end

obj = MyClass.new
obj.my_method
obj.my_method
puts "#{__LINE__}, #{local_variables}"