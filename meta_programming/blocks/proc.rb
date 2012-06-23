#!/usr/bin/env ruby
inc = Proc.new {|x| x+1}
inc2 = lambda {|x| x+2}
inc3 = proc {|x| x+3}

puts inc.call(1)
puts inc2.call(1)
puts inc3.call(1)

def math(a,b)
  yield(a,b)
end
def teach_match(a,b,&operation)
  puts "Let's do the math:"
  puts math(a,b,&operation)
end

teach_match(2,3) {|x,y| x*y} 