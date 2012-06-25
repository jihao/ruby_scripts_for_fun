#!/usr/bin/env ruby -wKU
def method(arg, &block)
  yield(arg)
end

method(1) do |x| 
  puts x
end

method(1) { |x| 
  puts x
}

p1 = proc {|x| puts x}
method 2, &p1