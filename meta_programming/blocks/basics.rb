#!/usr/bin/env ruby
def a_method(a,b)
  a+yield(a,b)
end
puts a_method(1,2) {|x,y| (x+y)*3}

def a_method
  return yield if block_given?
  'no block'
end

puts a_method
puts a_method {'it is a block'}