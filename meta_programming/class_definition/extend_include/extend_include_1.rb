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
  include ExtendInclude1
end

obj = MyClass.new
obj.hello
obj.hello_module
