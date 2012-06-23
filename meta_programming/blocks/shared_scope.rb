#!/usr/bin/env ruby
def define_methods
  shared = 0
  puts self
  
  # define_method is private, so here we have to use dynamic method
  Kernel.send :define_method, :counter do
    shared
  end
  Kernel.send :define_method, :inc do |x|
    shared+=x
  end
end
define_methods
inc 4
puts counter

obj = Object.new
puts obj.respond_to? :define_method
puts Object.respond_to? :define_method
puts Kernel.respond_to? :define_method  # private, false
puts Module.respond_to? :define_method