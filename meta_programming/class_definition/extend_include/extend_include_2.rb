#!/usr/bin/env ruby -wKU
module ExtendInclude1
  def hello_module
    puts "hello from module"
  end
end

class MyClass
  def hello
    puts "hello from class"
  end
  
  # extend - Adds to obj the instance methods from each module given as a parameter.
  puts self
  extend ExtendInclude1
end

obj2 = MyClass.new
obj2.hello
MyClass.hello_module