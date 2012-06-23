#!/usr/bin/env ruby
def my_method
  x='Goodbye'
  yield('cruel')
end
x="Hello"
puts my_method{|y| "#{x}, #{y} world"}

# 块看到的是块定义时绑定的x
# 方法中的x对于块不可见